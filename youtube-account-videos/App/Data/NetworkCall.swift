//
//  NetworkCall.swift
//  youtube-account-videos
//
//
//

import Foundation

enum NetworkError: Error {
    case invalidChannel
    case invalidURL
    case invalidResponse
    case code400, code403
    case invalidData
}

final class NetworkCall { // singleton
    static let shared = NetworkCall()
    private init() {}
    
    static let baseUrl = "https://www.googleapis.com/youtube/v3/"

    func getVideos(madeBy channel: String) async throws -> VideoSearch {
        guard !channel.isEmpty else {
            throw NetworkError.invalidChannel
        }
        
        let endpoint = "search?key=\(Secret.apiKeys.youtube.rawValue)&part=snippet,id&channelId=\(channel)&type=video&maxResults=20&order=date"
        
        guard let url = URL(string: NetworkCall.baseUrl + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let securedResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch securedResponse.statusCode {
        case 400:
            throw NetworkError.code400
        case 403:
            throw NetworkError.code403
        default:
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                return try decoder.decode(VideoSearch.self, from: data)
            } catch {
                throw NetworkError.invalidData
            }
        }
    }
}

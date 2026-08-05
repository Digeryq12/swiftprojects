//
//  DataModel.swift
//  youtube-account-videos
//
//
//

import Foundation

@Observable class DataModel {
    var currentChannel = ""
    var currentVideo: Video?
    var searchResult: VideoSearch = VideoSearch(pageInfo: [:], items: [])
    var searchError = ""
    var showingSearchAlert = false
    
    var channelData: [String] {
        let videos = searchResult.items
        if videos.isEmpty {
            return ["Unknown ID", "Unknown Channel"]
        } else {
            let snippet = videos[0].snippet
            return [snippet.channelId, snippet.channelTitle]
        }
    }
    
    var alertData: [String] {
        return searchError.isEmpty ? ["Success", "Successfully loaded content"] : ["Error", searchError]
    }
    
    func listVideos() {
        Task {
            searchError = ""
            
            do {
                searchResult = try await NetworkCall.shared.getVideos(madeBy: currentChannel)
            } catch NetworkError.invalidChannel {
                searchError = "The input channel ID is invalid (empty)"
            } catch NetworkError.invalidURL {
                searchError = "There was an issue forming the request URL"
            } catch NetworkError.invalidResponse {
                searchError = "The received response is not valid"
            } catch NetworkError.code400 {
                searchError = "Status code 400"
            } catch NetworkError.code403 {
                searchError = "Status code 403"
            } catch NetworkError.invalidData {
                searchError = "Unable to load the data from the JSON string"
            }
            
            showingSearchAlert = true
        }
    }
}

//
//  Video.swift
//  youtube-account-videos
//
//
//

import Foundation

struct VideoThumbnail: Decodable {
    let url: String
}

struct VideoSnippet: Decodable {
    let publishedAt: Date
    let title: String
    //let description: String
    let thumbnails: [String: VideoThumbnail]
    
    let channelId: String
    let channelTitle: String
}

struct Video: Decodable, Identifiable {
    let id: [String: String]
    let snippet: VideoSnippet
}

struct VideoSearch: Decodable {
    let pageInfo: [String: Int]
    let items: [Video]
}

// ---

struct VideoExample {
    static let defaultVideo = Video(id: [
                                        "kind": "",
                                        "videoId": "kwmHaXUAa0M"
                                    ],
                                    snippet: VideoSnippet(
                                            publishedAt: Date(),
                                            title: "Abstract White Background 4K - Motion Graphics Background Loop - White Video Loop",
                                            thumbnails: ["default": VideoThumbnail(url: "https://i.ytimg.com/vi/kwmHaXUAa0M/default.jpg")],
                                            channelId: "UCKD5rAtc1ITj4AINzqmYMog",
                                            channelTitle: "Free Stock Footage 4K",
                                        ),
                                    )
    
    static let defaultSearch = VideoSearch(pageInfo: [
                                            "totalResults": videoListSample.count,
                                            "resultsPerPage": 20
                                           ],
                                           items: videoListSample)
    
    static let videoListSample = [defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo]
}

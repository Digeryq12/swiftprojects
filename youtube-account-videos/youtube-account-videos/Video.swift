//
//  Video.swift
//  youtube-account-videos
//
//  Created by Berta on 2026. 08. 01..
//

import Foundation

struct VideoThumbnail: Decodable {
    let url: String
}

struct VideoSnippet: Decodable {
    let publishedAt: String // datetime format
    let title: String
    let description: String
    let thumbnails: [String: VideoThumbnail]
}

struct Video: Decodable, Identifiable {
    let id: String
    let snippet: VideoSnippet
}

struct VideoSearch: Decodable {
    let pageInfo: [String: Int]
    let items: [Video]
}

// ---

struct VideoExample {
    static let defaultVideo = Video(id: "kwmHaXUAa0M",
                                    snippet: VideoSnippet(
                                        publishedAt: "2019-11-22T13:45:21Z",
                                        title: "Abstract White Background 4K - Motion Graphics Background Loop - White Video Loop",
                                        description: "100% FREE STOCK FOOTAGE - Free commercial use! No Copyright! No Credits Required! Royalty Free! https://bit.ly/2pwLDtW ...",
                                        thumbnails: ["default": VideoThumbnail(url: "https://i.ytimg.com/vi/kwmHaXUAa0M/default.jpg")])
                                    )
    
    static let videoListSample = [defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo, defaultVideo]
}

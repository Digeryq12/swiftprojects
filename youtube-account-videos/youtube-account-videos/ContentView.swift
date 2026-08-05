//
//  ContentView.swift
//  youtube-account-videos
//
//  Created by Berta on 2026. 08. 01..
//

import SwiftUI

struct ContentView: View {
    @State private var currentVideo: Video?
    private let dateFormatter = ISO8601DateFormatter()
    
    var body: some View {
        NavigationStack {
            List(VideoExample.videoListSample, id: \.id) { video in
                Button {
                    currentVideo = video
                } label: {
                    HStack(spacing: 20) {
                        AsyncImage(url: URL(string: video.snippet.thumbnails["default"]?.url ?? "https://digerys.neocities.org/images/youtubedeleted.jpg")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            Image("youtubedeleted")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        VStack(spacing: 7) {
                            Text(video.snippet.title)
                                .foregroundStyle(Color(.label))
                                .font(.title3)
                                .lineLimit(3)
                            
                            Text(video.snippet.publishedAt)
                                .foregroundStyle(Color(.secondaryLabel))
                                .scaledToFit()
                        }
                    }
                }
            }.navigationTitle("📹 Content")
             .sheet(item: $currentVideo) { video in
                 SafariView(url: URL(string: "https://youtube.com/watch?v=\(video.id)") ?? URL(string: "https://youtube.com")!)
             }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchResult.items, id: \.id["videoId"]) { video in
                Button {
                    viewModel.currentVideo = video
                } label: {
                    VideoListItem(video: video)
                }
                
            }.navigationTitle("📹 Content")
            .sheet(item: $viewModel.currentVideo) { video in
             SafariView(url: URL(string: "https://youtube.com/watch?v=\(video.id["videoId"] ?? "")") ?? URL(string: "https://youtube.com")!)
             }
            
            ResultsStack(pageInfo: viewModel.searchResult.pageInfo)
        }
    }
}

struct VideoListItem: View {
    var video: Video
    
    var body: some View {
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
            
            VStack(alignment: .leading, spacing: 7) {
                Text(video.snippet.title)
                    .foregroundStyle(Color(.label))
                    .font(.title3)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                Text(video.snippet.publishedAt.formatted(date: .abbreviated, time: .shortened))
                    .foregroundStyle(Color(.secondaryLabel))
                    .scaledToFit()
            }
        }
    }
}

struct ResultsStack: View {
    var pageInfo: [String: Int]
    
    var body: some View {
        HStack {
            Text("Total Results: \(pageInfo["totalResults"] ?? 0)")
            Spacer()
                .frame(width: 30)
            Text("Results Per Page: \(pageInfo["resultsPerPage"] ?? 20)")
        }.padding()
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}

//
//  ContentView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct MainView: View {
    @State var ytAPIModel = YoutubeAPIModel()
    
    var body: some View {
        TabView {
            Tab("Content", systemImage: "video") {
                ContentView(ytAPIModel: ytAPIModel)
            }
            Tab("Channel", systemImage: "person.fill") {
                ChannelView(ytAPIModel: ytAPIModel)
            }
        }
    }
}

#Preview {
    MainView()
}

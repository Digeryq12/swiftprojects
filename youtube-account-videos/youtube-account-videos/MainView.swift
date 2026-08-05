//
//  ContentView.swift
//  youtube-account-videos
//
//  Created by Berta on 2026. 08. 01..
//

import SwiftUI

struct MainView: View {
    @State var ytAPIModel = YoutubeAPIModel()
    
    var body: some View {
        TabView {
            Tab("Content", systemImage: "video") {
                ContentView()
            }
            Tab("Channel", systemImage: "person.fill") {
                ChannelView()
            }
        }
    }
}

#Preview {
    MainView()
}

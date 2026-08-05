//
//  ContentView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct MainView: View {
    @State var dataModel = DataModel()
    
    var body: some View {
        TabView {
            Tab("Content", systemImage: "video") {
                ContentView(dataModel: dataModel)
            }
            Tab("Channel", systemImage: "person.fill") {
                ChannelView(dataModel: dataModel)
            }
        }
    }
}

#Preview {
    MainView()
}

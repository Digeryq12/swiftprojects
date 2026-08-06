//
//  ContentView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct MainView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            Tab("Content", systemImage: "video") {
                ContentView(viewModel: viewModel)
            }
            Tab("Channel", systemImage: "person.fill") {
                ChannelView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    MainView()
}

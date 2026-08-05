//
//  ChannelView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct ChannelView: View {
    @State var ytAPIModel: YoutubeAPIModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ChannelStack(channelData: ytAPIModel.channelData)
                
                Spacer()
                    .frame(height: 75)
                
                SearchStack(ytAPIModel: ytAPIModel)
                
            }.navigationTitle("🧑‍💻 Channel")
            .alert(ytAPIModel.alertData[0], isPresented: $ytAPIModel.showingSearchAlert, presenting: ytAPIModel.alertData[1]) { _ in
                Button {} label: {
                    Text("OK")
                }
            } message: { error in
                Text(error)
            }
        }
    }
}

struct ChannelStack: View {
    var channelData: [String]
    
    var body: some View {
        VStack {
            Text(channelData[1])
                .font(.title)
            
            Text(channelData[0])
                .font(.title3)
                .foregroundStyle(Color(.secondaryLabel))
        }
    }
}

struct SearchStack: View {
    @State var ytAPIModel: YoutubeAPIModel
    
    var body: some View {
        TextField("Input Channel ID...", text: $ytAPIModel.currentChannel)
            .frame(width: 240, height: 30)
            .padding(.horizontal, 10)
            .border(Color(.secondaryLabel))
        
        Button {
            ytAPIModel.listVideos()
        } label: {
            Text("Load Videos")
        }.padding(.top, 15)
    }
}

#Preview {
    ChannelView(ytAPIModel: YoutubeAPIModel())
}

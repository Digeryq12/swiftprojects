//
//  ChannelView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct ChannelView: View {
    @State var dataModel: DataModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ChannelStack(channelData: dataModel.channelData)
                
                Spacer()
                    .frame(height: 75)
                
                SearchStack(dataModel: dataModel)
                
            }.navigationTitle("🧑‍💻 Channel")
            .alert(dataModel.alertData[0], isPresented: $dataModel.showingSearchAlert, presenting: dataModel.alertData[1]) { _ in
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
    @State var dataModel: DataModel
    
    var body: some View {
        TextField("Input Channel ID...", text: $dataModel.currentChannel)
            .frame(width: 240, height: 30)
            .padding(.horizontal, 10)
            .border(Color(.secondaryLabel))
        
        Button {
            dataModel.listVideos()
        } label: {
            Text("Load Videos")
        }.padding(.top, 15)
    }
}

#Preview {
    ChannelView(dataModel: DataModel())
}

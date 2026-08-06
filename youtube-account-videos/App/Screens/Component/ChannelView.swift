//
//  ChannelView.swift
//  youtube-account-videos
//
//
//

import SwiftUI

struct ChannelView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ChannelStack(channelData: viewModel.channelData)
                
                Spacer()
                    .frame(height: 75)
                
                SearchStack(viewModel: viewModel)
                
            }.navigationTitle("🧑‍💻 Channel")
            .alert(viewModel.alertData[0], isPresented: $viewModel.showingSearchAlert, presenting: viewModel.alertData[1]) { _ in
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
    @State var viewModel: ViewModel
    
    var body: some View {
        TextField("Input Channel ID...", text: $viewModel.currentChannel)
            .frame(width: 240, height: 30)
            .padding(.horizontal, 10)
            .border(Color(.secondaryLabel))
        
        Button {
            viewModel.listVideos()
        } label: {
            Text("Load Videos")
        }.padding(.top, 15)
    }
}

#Preview {
    ChannelView(viewModel: ViewModel())
}

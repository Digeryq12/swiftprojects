//
//  GameView.swift
//  memory-game
//
//  Created by Digery on 2026. 08. 17..
//

// Why the fuck did it take longer to refactor than code the entire project??
// Anyways don't judge the code too hard, just a begginner :)

import SwiftUI

struct GameView: View {
    @State private var vm = GameVM()
    
    var body: some View {
        VStack {
            GameTitle()
            
            Spacer()
            
            LazyHGrid(rows: vm.gridItems) {
                ForEach(0..<4) { i in
                    BoardButton(color: vm.determineColor(i))
                        .onTapGesture {
                            if vm.boardEnabled {
                                vm.pressedColor(color: vm.determineColor(i))
                            }
                        }
                }
            }
            .frame(height: 310)
            .padding(.bottom, 40)
            
            PrimaryButton(vm: vm, currentState: vm.primaryButtonState)
                .padding(.bottom, 50)
            
            scoreLabels(scores: [vm.score, vm.highScore])
                .padding(.bottom, 30)
            
            DifficultyInput(vm: vm)
                .padding(.bottom, 10)
        }
    }
}

struct GameTitle: View {
    var body: some View {
        Text("2x2 Memory Game")
            .font(.system(.largeTitle, design: .monospaced))
            .fontWeight(.semibold)
            .padding(.top, 20)
    }
}

struct BoardButton: View {
    var color = Color(.systemBackground)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(color)
            .frame(width: 130, height: 130)
            .padding(.horizontal, 10)
    }
}

struct PrimaryButton: View {
    @State var vm: GameVM
    var currentState: (String, String, Color)
    
    var body: some View {
        Button {
            vm.loopRunning ? vm.stopLoop() : vm.showLoop()
        } label: {
            Label(currentState.0, systemImage: currentState.1)
                .font(.title2)
                .fontWeight(.bold)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .tint(currentState.2)
    }
}

struct scoreLabels: View {
    var scores: [Int]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Current score: \(scores[0])")
                .font(.title2)
            Text("Highscore: \(scores[1])")
                .font(.title2)
                .bold()
        }
    }
}

struct DifficultyInput: View {
    @State var vm: GameVM
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("2", text: $vm.difficultyInput)
                .frame(width: 50, height: 40)
                .background(Color(.quaternaryLabel))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .multilineTextAlignment(.center)
                .keyboardType(.default)
            
            Text("Game difficulty")
        }
    }
}

#Preview {
    GameView()
}

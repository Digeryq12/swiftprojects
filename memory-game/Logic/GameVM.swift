//
//  GameVM.swift
//  memory-game
//
//  Created by Digery on 2026. 08. 17..
//

// All logic is handled here, for one tiny exception

import SwiftUI
import AVFoundation

@Observable class GameVM {
    let boardColors: [Color] = [.darkRed, .darkGreen, .darkBlue, .darkYellow]
    let boardRows = 2
    var gridItems: [GridItem] {
        var arrayOfRows: [GridItem] = []
        for _ in 1...boardRows {
            arrayOfRows.append(GridItem(.flexible()))
        }
        return arrayOfRows
    }
    
    var difficultyInput = "2"
    var gameSpeed: Double {
        return 1.0/(Double(difficultyInput) ?? 2.0)
    }
    
    var determineColor: (Int) -> Color { // computed property + closure
        { i in
            return self.boardColors[i] == self.currentColor ? self.currentColor!.retrieveLightVersion() : self.boardColors[i]
        }
    }
    
    var boardEnabled: Bool {
        return !showingPattern && loopRunning
    }
    
    var primaryButtonState: (String, String, Color) {
        if !loopRunning {
            return ("Start game", "play.fill", .green)
        } else {
            return ("Stop game", "stop.fill", .red)
        }
    }
    
    //----------
    
    var score = 0
    var highScore = 0
    
    var timer: Timer?
    var subTimer: Timer?
    var soundPlayer: AVAudioPlayer?
    
    var currentColor: Color?
    var pattern: [Color] = []
    var inputColors: [Color] = []
    
    var loopRunning = false
    var showingPattern = false
    
    func showLoop() {
        var runs = 0
        
        loopRunning = true
        showingPattern = true
        
        self.pattern.append(self.boardColors.randomElement() ?? .black)
        
        timer = Timer.scheduledTimer(withTimeInterval: self.gameSpeed+0.3, repeats: true, block: { _ in
            
            self.currentColor = nil
            
            if runs < self.pattern.count {
                
                self.currentColor = self.pattern[runs]
                self.playSound(sound: self.currentColor?.retrieveSound() ?? "sound1")
                
                runs += 1
                
                self.subTimer = Timer.scheduledTimer(withTimeInterval: self.gameSpeed, repeats: false, block: { _ in
                    self.currentColor = nil
                })
                
            } else {
                
                self.showingPattern = false
                self.inputColors = self.pattern
                self.timer?.invalidate()
            }
        })
    }
    
    func pressedColor(color: Color) {
        if inputColors.first == color {
            
            subTimer?.invalidate()
            
            inputColors.remove(at: 0)
            
            currentColor = color
            playSound(sound: color.retrieveSound())
            
            subTimer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: false, block: { _ in
                self.currentColor = nil
            })
        } else {
            
            stopLoop()
            playSound(sound: "fail")
            return
        }
        
        if inputColors.isEmpty {
            score += 1
            showLoop()
        }
    }
    
    func stopLoop() {
        
        timer?.invalidate()
        subTimer?.invalidate()
        currentColor = nil
        pattern = []
        inputColors = []
        showingPattern = false
        loopRunning = false
        
        if score > highScore {
            highScore = score
        }
        
        score = 0
    }
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
            return
        }
        
        soundPlayer?.stop()
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch {
            print("There was an issue trying to play a sound.")
        }
    }
}

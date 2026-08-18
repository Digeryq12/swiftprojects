//
//  Color+ext.swift
//  memory-game
//
//  Created by Digery on 2026. 08. 17..
//

import SwiftUI

extension Color {
    func retrieveLightVersion() -> Color {
        
        let colorMap: [Color: Color] = [
            .darkRed: .red,
            .darkBlue: .blue,
            .darkGreen: .green,
            .darkYellow: .yellow,
        ]
        
        return colorMap[self] ?? .black
    }
    
    func retrieveSound() -> String {
        
        let soundMap: [Color: String] = [
            .darkRed: "beep0",
            .darkBlue: "beep1",
            .darkGreen: "beep2",
            .darkYellow: "beep3",
        ]
        
        return soundMap[self] ?? "beep1"
    }
}

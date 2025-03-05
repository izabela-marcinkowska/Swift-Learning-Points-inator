//
//  LevelIndicator.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-05.
//

import SwiftUI

struct LevelIndicator: View {
    let level: SchoolOfMagic.AchievementLevel
    let isAchieved: Bool
    
    var body: some View {
        HStack {
            Image(level.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
            
            Text(level.title)
                .font(.caption2)
                .fontWeight(isAchieved ? .bold : .regular)
                .foregroundColor(isAchieved ? level.color : .gray.opacity(0.5))
        }
    }
}

struct LevelProgressionBar: View {
    let currentLevel: SchoolOfMagic.AchievementLevel
    
    var body: some View {
        VStack(spacing: 4) {
            ForEach(SchoolOfMagic.AchievementLevel.allCases, id: \.self) { level in
                LevelIndicator(
                    level: level,
                    isAchieved: level.rawValue <= currentLevel.rawValue
                )
            }
        }
    }
}

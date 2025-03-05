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
        Text(level.title)
            .font(.caption2)
            .fontWeight(isAchieved ? .bold : .regular)
            .foregroundColor(isAchieved ? level.color : .gray.opacity(0.5))
    }
}

struct LevelProgressionBar: View {
    let currentLevel: SchoolOfMagic.AchievementLevel
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(SchoolOfMagic.AchievementLevel.allCases, id: \.self) { level in
                LevelIndicator(
                    level: level,
                    isAchieved: level.rawValue <= currentLevel.rawValue
                )
            }
        }
    }
}

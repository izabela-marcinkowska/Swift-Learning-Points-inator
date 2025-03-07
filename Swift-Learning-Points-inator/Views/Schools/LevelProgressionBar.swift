//
//  LevelProgressionBar.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-07.
//

import SwiftUI

struct LevelProgressionBar: View {
    let currentLevel: SchoolOfMagic.AchievementLevel
    let manaProgress: String
    let totalMana: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Current level:")
                .font(.headline)
            ForEach(SchoolOfMagic.AchievementLevel.allCases, id: \.self) { level in
                let progressToShow = level == currentLevel ? manaProgress : nil
                let isCurrent = level == currentLevel
                
                // Determine status text using the model methods
                let statusText: String? = {
                    if level.rawValue < currentLevel.rawValue {
                        return "Achieved!"
                    } else if level.rawValue == currentLevel.rawValue {
                        if level == .grandSorcerer {
                            return "Maximum level achieved"
                        } else {
                            let nextLevel = SchoolOfMagic.AchievementLevel(rawValue: level.rawValue + 1)!
                            let manaNeeded = nextLevel.manaNeededFrom(currentMana: totalMana)
                            return "For \(nextLevel.title), need \(manaNeeded) more mana"
                        }
                    } else {
                        let manaNeeded = level.manaNeededFrom(currentMana: totalMana)
                        return "Need \(manaNeeded) more mana to unlock"
                    }
                }()
                
                LevelIndicator(
                    level: level,
                    isAchieved: level.isAchieved(withMana: totalMana),
                    progressText: progressToShow,
                    statusText: statusText,
                    isCurrent: isCurrent
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .withCardStyle(useGradient: false)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

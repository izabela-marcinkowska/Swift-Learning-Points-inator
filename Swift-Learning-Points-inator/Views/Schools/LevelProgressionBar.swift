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
    
    /// Provides a human-readable status message for a given achievement level.
    ///
    /// This method determines the appropriate status text based on the relationship
    /// between the specified level and the user's current achievement level:
    /// - For past levels: Shows an "Achieved!" message
    /// - For the current level: Shows progress toward the next level
    /// - For future levels: Shows mana required to unlock
    ///
    /// - Parameter level: The achievement level to generate status text for
    /// - Returns: A formatted status message appropriate for the level's state
    private func statusTextFor(level: SchoolOfMagic.AchievementLevel) -> String {
        if level.rawValue < currentLevel.rawValue {
            return "Achieved!"
        } else if level == currentLevel {
            if level == .grandSorcerer {
                return "Maximum level achieved"
            } else {
                guard let nextLevel = SchoolOfMagic.AchievementLevel(rawValue: level.rawValue + 1) else {
                    return "Error calculating next level"
                }
                let manaNeeded = nextLevel.manaNeededFrom(currentMana: totalMana)
                return "For \(nextLevel.title), need \(manaNeeded) more mana"
            }
        } else {
            let manaNeeded = level.manaNeededFrom(currentMana: totalMana)
            return "Need \(manaNeeded) more mana to unlock"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Current level:")
                .font(.headline)
            
            ForEach(SchoolOfMagic.AchievementLevel.allCases, id: \.self) { level in
                let progressToShow = level == currentLevel ? manaProgress : nil
                let isCurrent = level == currentLevel
                
                LevelIndicator(
                    level: level,
                    isAchieved: level.isAchieved(withMana: totalMana),
                    progressText: progressToShow,
                    statusText: statusTextFor(level: level),
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

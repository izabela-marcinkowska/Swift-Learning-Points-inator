//
//  SchoolProgress.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-16.
//

import Foundation
import SwiftData

/// Tracks a user's progress in a specific School of Magic, including total mana earned
/// and achievement level within that school.
@Model
class SchoolProgress {
    /// Raw string representation of the school type, used for SwiftData persistence
    var schoolRaw: String
    /// Total amount of mana earned in this school through completed tasks
    var totalMana: Int
    
    /// The School of Magic this progress tracks.
    /// Uses a computed property to convert between the raw stored string and the SchoolOfMagic enum.
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .everydayEndeavors
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    /// Current achievement level in this school, calculated based on total mana earned.
    /// The level increases automatically as more mana is accumulated.
    /// - Note: Level thresholds are defined in `SchoolOfMagic.AchievementLevel`
    var currentLevel: SchoolOfMagic.AchievementLevel {
        SchoolOfMagic.AchievementLevel.level(for: totalMana)
    }
    
    var lastLevelUpdate: Date?
    
    init(
        school: SchoolOfMagic = .everydayEndeavors,
        totalMana: Int = 0,
        lastLevelUpdate: Date? = nil
    ) {
        self.schoolRaw = school.rawValue
        self.totalMana = totalMana
        self.lastLevelUpdate = lastLevelUpdate
    }
}

extension SchoolProgress {
    /// Returns the next level for this school if it exists
    var nextLevel: SchoolOfMagic.AchievementLevel? {
        guard currentLevel.rawValue < SchoolOfMagic.AchievementLevel.allCases.count - 1 else {
            return nil // Already at max level
        }
        return SchoolOfMagic.AchievementLevel(rawValue: currentLevel.rawValue + 1)
    }
    
    /// Calculates the normalized progress (0-1) towards the next level
    var progressToNextLevel: Double {
        guard let nextLevel = nextLevel else {
            return 1.0 // Already at max level
        }
        
        let currentThreshold = currentLevel.manaThreshold
        let nextThreshold = nextLevel.manaThreshold
        let manaForNextLevel = nextThreshold - currentThreshold
        let currentProgress = totalMana - currentThreshold
        
        return manaForNextLevel > 0 ?
            min(max(Double(currentProgress) / Double(manaForNextLevel), 0), 1) : 0
    }
    
    /// Amount of mana needed to reach the next level
    var manaNeededForNextLevel: Int {
        guard let nextLevel = nextLevel else {
            return 0 // Already at max level
        }
        
        return max(0, nextLevel.manaThreshold - totalMana)
    }
    
    /// Returns appropriate text for displaying mana progress
    var manaProgressText: String {
        let nextThreshold = nextLevel?.manaThreshold ?? totalMana
        return "\(totalMana)/\(nextThreshold)"
    }
    
    /// Text to display about level progress
    var levelUpText: String {
        guard let nextLevel = nextLevel else {
            return "Maximum level achieved"
        }
        
        return "For \(nextLevel.title), need \(manaNeededForNextLevel) more mana"
    }
    
    /// Detects if adding the specified mana would cause a level up
    func wouldLevelUp(withAdditionalMana additionalMana: Int) -> Bool {
        let currentLvl = currentLevel
        let newLevel = SchoolOfMagic.AchievementLevel.level(for: totalMana + additionalMana)
        return newLevel.rawValue > currentLvl.rawValue
    }
    
    /// Predicts the new level after adding mana
    func predictedLevel(withAdditionalMana additionalMana: Int) -> SchoolOfMagic.AchievementLevel {
        return SchoolOfMagic.AchievementLevel.level(for: totalMana + additionalMana)
    }
    
    /// Text to display about level progress for a specific level
    func getLevelStatusText(for level: SchoolOfMagic.AchievementLevel) -> String {
        if level.rawValue < currentLevel.rawValue {
            return "Achieved!"
        } else if level.rawValue == currentLevel.rawValue {
            // Use existing levelUpText logic for current level
            if level == .grandSorcerer {
                return "Maximum level achieved"
            } else if let nextLevel = nextLevel {
                let manaNeeded = manaNeededForNextLevel
                return "For \(nextLevel.title), need \(manaNeeded) more mana"
            }
        } else {
            // For future levels
            let manaNeeded = level.manaNeededFrom(currentMana: totalMana)
            return "Need \(manaNeeded) more mana to unlock"
        }
        
        return ""
    }
}

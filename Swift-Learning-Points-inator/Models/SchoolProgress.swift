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
    /// Returns the next achievement level for this school if it exists.
    /// Returns nil if already at the maximum level (Grand Sorcerer).
    ///
    /// For example, if current level is 'apprentice' (0), returns 'mage' (1).
    /// If current level is 'grandSorcerer' (3), returns nil.
    var nextLevel: SchoolOfMagic.AchievementLevel? {
        guard currentLevel.rawValue < SchoolOfMagic.AchievementLevel.allCases.count - 1 else {
            return nil // Already at max level
        }
        return SchoolOfMagic.AchievementLevel(rawValue: currentLevel.rawValue + 1)
    }
    
    /// Calculates progress towards the next level as a value between 0 and 1.
    /// This value is used for the progress bar visualization.
    ///
    /// The calculation works as follows:
    /// 1. Checks if we have all required values (current level, mana, and next level exists)
    /// 2. Gets mana thresholds for current and next level
    /// 3. Calculates how much mana is needed for next level
    /// 4. Determines current progress within that range
    /// 5. Returns progress as a percentage (0-1)
    ///
    /// Returns 1.0 if already at maximum level.
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
    
    /// Amount of mana needed to reach the next level for this school.
    /// Returns zero if already at the maximum level.
    var manaNeededForNextLevel: Int {
        guard let nextLevel = nextLevel else {
            return 0 // Already at max level
        }
        
        return max(0, nextLevel.manaThreshold - totalMana)
    }
    
    /// Returns appropriate text for displaying mana progress.
    /// Format: "currentMana/nextLevelThreshold"
    ///
    /// Examples:
    /// - "150/300" (150 mana earned, need 300 for next level)
    /// - "2600/2600" (at max level, showing current mana)
    var manaProgressText: String {
        let nextThreshold = nextLevel?.manaThreshold ?? totalMana
        return "\(totalMana)/\(nextThreshold)"
    }
    
    /// Generates text explaining current level progress and requirements for next level.
    /// Different messages are shown depending on whether the maximum level has been reached.
    var levelUpText: String {
        guard let nextLevel = nextLevel else {
            return "Maximum level achieved"
        }
        
        return "For \(nextLevel.title), need \(manaNeededForNextLevel) more mana"
    }
    
    /// Detects if adding the specified mana would cause a level up.
    ///
    /// - Parameter additionalMana: The amount of mana to be added hypothetically
    /// - Returns: True if the additional mana would result in a level increase
    func wouldLevelUp(withAdditionalMana additionalMana: Int) -> Bool {
        let currentLvl = currentLevel
        let newLevel = SchoolOfMagic.AchievementLevel.level(for: totalMana + additionalMana)
        return newLevel.rawValue > currentLvl.rawValue
    }
    
    /// Predicts the achievement level that would be reached after adding additional mana.
    ///
    /// - Parameter additionalMana: The amount of mana to be added hypothetically
    /// - Returns: The achievement level that would be reached with the combined mana
    func predictedLevel(withAdditionalMana additionalMana: Int) -> SchoolOfMagic.AchievementLevel {
        return SchoolOfMagic.AchievementLevel.level(for: totalMana + additionalMana)
    }
    
    /// Generates appropriate descriptive text about the status of a specific achievement level.
    /// Text varies based on whether the level is already achieved, current, or future.
    ///
    /// - Parameter level: The achievement level to generate status text for
    /// - Returns: Formatted string describing the level's status relative to current progress
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

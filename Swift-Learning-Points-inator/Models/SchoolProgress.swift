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
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
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
        school: SchoolOfMagic = .arcaneStudies,
        totalMana: Int = 0,
        lastLevelUpdate: Date? = nil
    ) {
        self.schoolRaw = school.rawValue
        self.totalMana = totalMana
        self.lastLevelUpdate = lastLevelUpdate
    }
}

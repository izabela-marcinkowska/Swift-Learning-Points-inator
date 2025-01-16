//
//  SchoolProgress.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-16.
//

import Foundation
import SwiftData

@Model
class SchoolProgress {
    var schoolRaw: String // Replace `school` property with `schoolRaw`.
    var totalMana: Int
    var currentLevelRaw: Int // Replace `currentLevel` property with `currentLevelRaw`.
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    var currentLevel: SchoolOfMagic.AchievementLevel {
        get {
            SchoolOfMagic.AchievementLevel(rawValue: currentLevelRaw) ?? .apprentice
        }
        set {
            currentLevelRaw = newValue.rawValue
        }
    }
    
    // Default initial values for compatibility
    init(
        school: SchoolOfMagic = .arcaneStudies,
        totalMana: Int = 0,
        currentLevel: SchoolOfMagic.AchievementLevel = .apprentice
    ) {
        self.schoolRaw = school.rawValue
        self.totalMana = totalMana
        self.currentLevelRaw = currentLevel.rawValue
    }
}

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
    var schoolRaw: String
    var totalMana: Int
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    var currentLevel: SchoolOfMagic.AchievementLevel {
        SchoolOfMagic.AchievementLevel.level(for: totalMana)
    }
    
    init(
        school: SchoolOfMagic = .arcaneStudies,
        totalMana: Int = 0
    ) {
        self.schoolRaw = school.rawValue
        self.totalMana = totalMana
    }
}

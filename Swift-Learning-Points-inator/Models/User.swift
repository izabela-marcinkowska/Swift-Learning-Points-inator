//
//  User.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import Foundation
import SwiftData
import SwiftUI

/// Represents a user in the application with their progress, preferences, and achievements.
@Model
class User {
    var name: String
    var mana: Int
    var streak: Int
    var lastStreakDate: Date?
    var schoolProgress: [SchoolProgress]
    private var genderRaw: String
    
    var gender: UserGender {
        get {
            UserGender(rawValue: genderRaw) ?? .other
        }
        set {
            genderRaw = newValue.rawValue
        }
    }
    
    
    init(name: String = "", mana: Int = 0, streak: Int = 0, lastStreakDate: Date? = nil, gender: UserGender = .other) {
        self.name = name
        self.mana = mana
        self.streak = streak
        self.lastStreakDate = lastStreakDate
        self.genderRaw = gender.rawValue
        self.schoolProgress = SchoolOfMagic.allCases.map { school in
            SchoolProgress(school: school)
        }
    }
}

// MARK: - Streak Management
extension User {
    enum StreakStatus {
        case continuing
        case broken
        case noStreak
    }
    
    /// Check if user currently have a streak or the streak is broken.
    /// - Returns: ``StreakStatus`` of value `continuing`, `broken` or `noStreak`.
    func checkStreakStatus() -> StreakStatus {
        guard let lastDate = lastStreakDate else {
            return .noStreak
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let lastStreakDate = calendar.startOfDay(for: lastDate)
        
        if calendar.isDate(today, inSameDayAs: lastStreakDate) {
            return .continuing
        }
        
        if let dayAfterStreak = calendar.date(byAdding: .day, value: 1, to: lastStreakDate),
           calendar.isDate(today, inSameDayAs: dayAfterStreak) {
            return .continuing
        }
        
        return .broken
    }
    
    
    /// Updates the user's streak based on their activity pattern.
    ///
    /// Streaks continue if:
    /// - Task completed today
    /// - Task completed yesterday
    ///
    /// A streak breaks if more than one day passes between activities.
    func updateStreak() {
        let status = checkStreakStatus()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        switch status {
        case .noStreak:
            streak = 1
            lastStreakDate = today
        case .continuing:
            if let lastDate = lastStreakDate, !calendar.isDate(today, inSameDayAs: lastDate) {
                streak += 1
                lastStreakDate = today
            }
        case .broken:
            streak = 1
            lastStreakDate = today
        }
    }
}

// MARK: -  School Progress
extension User {
    /// Adds mana to the chosen school and checks for level progression.
    ///
    ///- Note: This method will also trigger level up notifications if applicable
    /// - Parameters:
    ///   - amount: Amount of mana to add (can be negative for deductions)
    ///   - school: Which ``SchoolOfMagic``are we adding the mana to
    ///
    func addMana(_ amount: Int, for school: SchoolOfMagic) {
        let currentLevel = schoolProgress.first(where: { $0.school == school})?.currentLevel ?? .apprentice
        
        if let progress = schoolProgress.first(where: { $0.school == school}) {
            progress.totalMana += amount
            
            let newLevel = progress.currentLevel
            if newLevel != currentLevel {
                progress.lastLevelUpdate = Date()
                print("Level up! Now you're \(school.titleForLevel(newLevel))")
            }
        }
        
    }
}

// MARK: - Recent Achivement
extension User {
    /// Represents a milestone achievement in the user's progression, either in a School of Magic or Spell mastery.
    struct RecentAchievement {
        /// Distinguishes between school-based and spell-based achievements.
        /// Each type carries its associated data (school/level or spell/level).
        enum AchievementType {
            case school(SchoolOfMagic, SchoolOfMagic.AchievementLevel)
            case spell (Spell, SpellLevel)
        }
        
        let type: AchievementType
        let date: Date
        
        /// Provides a human-readable description of the achievement.
        /// For schools: Returns the formatted title (e.g., "Archmage of Data Sorcery")
        /// For spells: Returns the spell name and level (e.g., "Mind Sharpening Charm reached Expert Level")
        var description: String {
            switch type {
            case .school(let school, let level):
                return school.titleForLevel(level)
            case .spell(let spell, let level):
                return "\(spell.name) reached \(level.title)"
            }
        }
    }
    
    /// Finds the most recently earned achievement across all schools and spells.
    /// - Parameter spells: Array of spells to check for recent level-ups
    /// - Returns: The most recent achievement if any exists, nil otherwise
    func getMostRecentAchievement(spells: [Spell]) -> RecentAchievement? {
        var allAchievements: [RecentAchievement] = []
        
        for progress in schoolProgress {
            if let date = progress.lastLevelUpdate {
                allAchievements.append(
                    RecentAchievement(type: .school(progress.school, progress.currentLevel),
                                      date: date
                                     )
                )
            }
        }
        
        for spell in spells {
            if let date = spell.lastLevelUpdate {
                allAchievements.append(
                    RecentAchievement(type: .spell(spell, spell.currentSpellLevel),
                                      date: date
                                     )
                )
            }
        }
        
        return allAchievements
            .sorted { $0.date > $1.date }
            .first
    }
    
}


extension User {
    /// Determines if adding mana would cause a level up for a specific school.
    ///
    /// - Parameters:
    ///   - mana: The amount of mana to hypothetically add
    ///   - school: The school of magic to check
    /// - Returns: True if adding the mana would cause a level increase
    func wouldLevelUp(withAdditionalMana mana: Int, for school: SchoolOfMagic) -> Bool {
        guard let progress = schoolProgress.first(where: { $0.school == school }) else {
            return false
        }
        
        return progress.wouldLevelUp(withAdditionalMana: mana)
    }
    
    /// Gets the current achievement level for a specific school of magic.
    ///
    /// - Parameter school: The school to get the level for
    /// - Returns: The current achievement level, defaulting to Apprentice if no progress exists
    func currentLevel(for school: SchoolOfMagic) -> SchoolOfMagic.AchievementLevel {
        return schoolProgress.first(where: { $0.school == school })?.currentLevel ?? .apprentice
    }
    
    /// Gets the current mana amount for a specific school of magic.
    ///
    /// - Parameter school: The school to get the mana for
    /// - Returns: The total mana earned for this school, or 0 if no progress exists
    func currentMana(for school: SchoolOfMagic) -> Int {
        return schoolProgress.first(where: { $0.school == school })?.totalMana ?? 0
    }
    
    /// Gets the SchoolProgress object for a specific school of magic.
    ///
    /// - Parameter school: The school to get progress for
    /// - Returns: The SchoolProgress object, or nil if none exists
    func getSchoolProgress(for school: SchoolOfMagic) -> SchoolProgress? {
        return schoolProgress.first(where: { $0.school == school })
    }
}

enum UserGender: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case other = "Other"
    
    var avatarName: String {
        switch self {
        case .female: return "female-avatar"
        case .male: return "male-avatar"
        case .other: return "other-avatar"
        }
    }
}

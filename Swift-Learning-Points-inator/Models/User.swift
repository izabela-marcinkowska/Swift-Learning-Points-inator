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
    var themePreferenceRaw: String
    
    // MARK: - Theme preference
    /// Setting raw value name of the theme.
    var themePreference: ThemePreference {
        get {
            ThemePreference(rawValue: themePreferenceRaw) ?? .system
        } set {
            themePreferenceRaw = newValue.rawValue
        }
    }
    
    /// Based on the all existing themes, gives ColorScheme or nil to use inside `preferredColorScheme`.
    var swiftUIColorScheme: ColorScheme? {
            switch themePreference {
            case .light:
                return .light
            case .dark:
                return .dark
            case .system:
                return nil
            }
        }

    
    init(name: String = "", mana: Int = 0, streak: Int = 0, lastStreakDate: Date? = nil, themePreference: ThemePreference = .system) {
        self.name = name
        self.mana = mana
        self.streak = streak
        self.lastStreakDate = lastStreakDate
        self.themePreferenceRaw = themePreference.rawValue
        self.schoolProgress = SchoolOfMagic.allCases.map { school in
            SchoolProgress(school: school)
        }
    }
}

/// Defines the available theme options for the application's appearance.
///
/// - light: Forces light mode regardless of system settings
///
/// - dark: Forces dark mode regardless of system settings
/// 
/// - system: Follows the device's appearance settings
enum ThemePreference: String, CaseIterable {
    case light = "Light Mode"
    case dark = "Dark Mode"
    case system = "System Default"
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
                print("Level up! Now you're \(school.titleForLevel(newLevel))")
            }
        }
        
    }
}



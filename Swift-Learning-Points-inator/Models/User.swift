//
//  User.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var mana: Int
    var streak: Int
    var lastStreakDate: Date?
    var schoolProgress: [SchoolProgress]
    
    init(name: String = "", mana: Int = 0, streak: Int = 0, lastStreakDate: Date? = nil) {
        self.name = name
        self.mana = mana
        self.streak = streak
        self.lastStreakDate = lastStreakDate
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
    
    func updateStreak() {
        let status = checkStreakStatus()
        
        switch status {
        case .noStreak:
            streak = 1
        case .continuing:
            self.streak += 1
        case .broken:
            streak = 1
        }
        
        lastStreakDate = Date()
    }
}

// MARK: -  School Progress
extension User {
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




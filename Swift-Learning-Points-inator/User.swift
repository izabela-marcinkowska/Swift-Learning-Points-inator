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
    
    func addMana(_ amount: Int, for school: SchoolOfMagic) {
        if let progress = schoolProgress.first(where: { $0.school == school}) {
            progress.totalMana += amount
        }
    }
}


@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var mana: Int
    private var schoolRaw: String  // Store rawValue for the enum
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    var isCompleted: Bool
    var completedDate: Date?
    
    init(id: UUID = UUID(), name: String, mana: Int, school: SchoolOfMagic = .arcaneStudies, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.mana = mana
        self.schoolRaw = school.rawValue  // Assign rawValue here
        self.isCompleted = isCompleted
        self.completedDate = nil
    }
    
    func toggleCompletion(for user: User) {
        isCompleted.toggle()
        if isCompleted {
            completedDate = Date()
            user.mana += mana
            user.addMana(mana, for: school)
            user.updateStreak()
        } else {
            completedDate = nil
            user.mana -= mana
            user.addMana(-mana, for: school)
        }
    }
}

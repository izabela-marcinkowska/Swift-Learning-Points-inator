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
    var points: Int
    var streak: Int
    var lastStreakDate: Date?
    
    init(name: String = "", points: Int = 0, streak: Int = 0, lastStreakDate: Date? = nil) {
        self.name = name
        self.points = points
        self.streak = streak
        self.lastStreakDate = lastStreakDate
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
}


@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var points: Int
    var isCompleted: Bool
    var completedDate: Date? 
    
    init(id: UUID = UUID(), name: String, points: Int, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.points = points
        self.isCompleted = isCompleted
        self.completedDate = nil
    }
    
    func toggleCompletion(for user: User) {
            isCompleted.toggle()
            if isCompleted {
                completedDate = Date()
                user.points += points
                user.updateStreak()
            } else {
                completedDate = nil
                user.points -= points
            }
        }
}

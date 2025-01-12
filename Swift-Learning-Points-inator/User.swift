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
}


@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var points: Int
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, points: Int, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.points = points
        self.isCompleted = isCompleted
    }
}

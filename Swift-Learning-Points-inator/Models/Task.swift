//
//  Task.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-17.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var mana: Int
    private var schoolRaw: String
    var isCompleted: Bool
    var completedDate: Date?
    var isRepeatable: Bool = false
    
    var completedToday: Bool {
        guard let completedDate else { return false }
        return Calendar.current.isDateInToday(completedDate)
    }
    
    var isAvaliable: Bool {
        if !isRepeatable {
            return !completedToday
        }
        return !isCompleted
    }
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    
    init(id: UUID = UUID(), name: String, mana: Int, school: SchoolOfMagic = .arcaneStudies, isCompleted: Bool = false, isRepeatable: Bool = false) {
        self.id = id
        self.name = name
        self.mana = mana
        self.schoolRaw = school.rawValue
        self.isCompleted = isCompleted
        self.completedDate = nil
        self.isRepeatable = isRepeatable
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


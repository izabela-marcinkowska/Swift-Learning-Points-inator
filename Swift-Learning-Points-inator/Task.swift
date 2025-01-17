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


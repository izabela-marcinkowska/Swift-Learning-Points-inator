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
    private var difficultyRaw: String
    
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
    
    var difficulty: TaskDifficulty {
        get {
            TaskDifficulty(rawValue: difficultyRaw) ?? .easy
        }
        set {
            difficultyRaw = newValue.rawValue
        }
    }
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    
    init(id: UUID = UUID(), name: String, mana: Int, school: SchoolOfMagic = .arcaneStudies, isCompleted: Bool = false, isRepeatable: Bool = false, difficulty: TaskDifficulty = .easy) {
        self.id = id
        self.name = name
        self.mana = mana
        self.schoolRaw = school.rawValue
        self.isCompleted = isCompleted
        self.completedDate = nil
        self.isRepeatable = isRepeatable
        self.difficultyRaw = difficulty.rawValue
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

enum TaskDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var icon: String {
        switch self {
        case .easy: return "1.circle"
        case .medium: return "2.circle"
        case .hard: return "3.circle"
        }
    }
    
    var suggestedManaRange: String {
        switch self {
        case .easy: return "20-40"
        case .medium: return "41-80"
        case .hard: return "81-120"
        }
    }
}

extension Task {
    func calculateTotalMana(for user: User, spells: [Spell]) -> Int {
        let baseAmount = mana
        let bonusAmount = user.calculateTotalBonus(for: school, baseMana: baseAmount, spells: spells)
        return baseAmount + bonusAmount
    }
    
    func toggleCompletion(for user: User, spells: [Spell]) {
        isCompleted.toggle()
        if isCompleted {
            completedDate = Date()
            let totalMana = calculateTotalMana(for: user, spells: spells)
            user.mana += totalMana
            user.addMana(totalMana, for: school)
            user.updateStreak()
        } else {
            completedDate = nil
            let totalMana = calculateTotalMana(for: user, spells: spells)
            user.mana -= totalMana
            user.addMana(-totalMana, for: school)
        }
    }
}

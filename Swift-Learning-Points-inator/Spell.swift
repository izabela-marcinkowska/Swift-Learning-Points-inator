//
//  Spell.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-28.
//

import Foundation
import SwiftData

enum SpellLevel: Int, CaseIterable {
    case novice = 1
    case adept = 2
    case expert = 3
    case master = 4
    
    
    var title: String {
        switch self {
        case .novice: return "Novice Charm"
        case .adept: return "Adept Charm"
        case .expert: return "Expert Charm"
        case .master: return "Master Charm"
        }
    }
    
    var manaCost: Int {
        switch self {
        case .novice: return 0
        case .adept: return 200
        case .expert: return 500
        case .master: return 1000
        }
    }
}

enum SpellCategory: String, CaseIterable {
    
    case focus = "Focus Enhancement"
    case restoration = "Restoration"
    case balance = "Balance"
    case clarity = "Clarity"
    case perseverance = "Perseverance"
    
    
    case seasonal = "Seasonal Spells"
    case event = "Event Spells"
    case achievement = "Achievement Spells"
    
    static let coreCategories: Set<SpellCategory> = [
        .focus, .restoration, .balance, .clarity, .perseverance
    ]
    
    var isPermanent: Bool {
        SpellCategory.coreCategories.contains(self)
    }
    
    var icon: String {
        switch self {
        case .focus:
            return "brain.filled.head.profile"
        case .restoration:
            return "battery.50percent"
        case .balance:
            return "scale.3d"
        case .clarity:
            return "light.beacon.max.fill"
        case .perseverance:
            return "figure.climbing"
        case .seasonal:
            return "snowflake"
        case .event:
            return "star.circle"
        case .achievement:
            return "trophy"
        }
    }
    
    var description: String {
        switch self {
        case .focus:
            return "Master spells that enhance your learning focus and concentration"
        case .restoration:
            return "Learn the art of taking breaks and recharging your magical energy"
        case .balance:
            return "Maintain harmony between coding practice and rest"
        case .clarity:
            return "Enhance your understanding of magical coding concepts"
        case .perseverance:
            return "Overcome challenges and build resilience in your magical journey"
        case .seasonal:
            return "Limited-time spells that change with the seasons"
        case .event:
            return "Special spells available during magical events"
        case .achievement:
            return "Powerful spells unlocked through your achievements"
        }
    }
}

@Model
class Spell {
    var name: String
    var spellDescription: String
    var currentLevel: Int
    var manaCost: Int
    var icon: String
    var categoryRaw: String
    
    var category: SpellCategory {
        get {
            SpellCategory(rawValue: categoryRaw) ?? .focus
        }
        set {
            categoryRaw = newValue.rawValue
        }
    }
    
    var currentSpellLevel: SpellLevel {
        return SpellLevel(rawValue: currentLevel) ?? .novice
    }
    
    init(
        name: String,
        spellDescription: String,
        category: SpellCategory = .focus,
        icon: String,
        currentLevel: Int = 1
    ) {
        self.name = name
        self.spellDescription = spellDescription
        self.currentLevel = currentLevel
        self.manaCost = SpellLevel.novice.manaCost
        self.icon = icon
        self.categoryRaw = category.rawValue
    }
    
    func canUpgrade(with availableMana: Int) -> Bool {
        guard currentLevel < SpellLevel.master.rawValue else { return false }
        let nextLevel = SpellLevel(rawValue: currentLevel + 1) ?? .novice
        return availableMana >= nextLevel.manaCost
    }
    
    func upgrade(for user: User) -> Bool {
        guard canUpgrade(with: user.mana) else { return false }
        
        let nextLevel = SpellLevel(rawValue: currentLevel + 1) ?? .novice
        user.mana -= nextLevel.manaCost
        currentLevel += 1
        manaCost = nextLevel.manaCost
        return true
    }
}

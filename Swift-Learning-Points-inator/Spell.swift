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
    case master = 3
    
    var title: String {
        switch self {
        case .novice: return "Novice"
        case .adept: return "Adept"
        case .master: return "Master"
        }
    }
    
    var manaCost: Int {
        switch self {
        case .novice: return 100
        case .adept: return 300
        case .master: return 500
        }
    }
}

enum SpellCategory: String, CaseIterable {
    case core = "Core Spells"
    case seasonal = "Seasonal Spells"
    case achievement = "Achievement Spells"
    case event = "Event Spells"
    
    var icon: String {
        switch self {
        case .core:
            return "wand.and.stars"
        case .seasonal:
            return "snowflake"
        case .achievement:
            return "trophy"
        case .event:
            return "star.circle"
        }
    }
    
    var description: String {
        switch self {
        case .core:
            return "Fundamental spells for every digital sorcerer"
        case .seasonal:
            return "Special spells that change with the seasons"
        case .achievement:
            return "Powerful spells unlocked through your achievements"
        case .event:
            return "Limited-time spells from special magical events"
        }
    }
    
    var isVisibleByDefault: Bool {
        switch self {
        case .core, .seasonal, .event:
            return true
        default:
            return false
        }
    }
}

@Model
class Spell {
    var name: String
    var spellDescription: String
    var currentLevel: Int
    var isUnlocked: Bool
    var manaCost: Int
    var icon: String
    
    var currentSpellLevel: SpellLevel {
        return SpellLevel(rawValue: currentLevel) ?? .novice
    }
    
    init(
        name: String,
        spellDescription: String,
        icon: String,
        currentLevel: Int = 1,
        isUnlocked: Bool = false
    ) {
        self.name = name
        self.spellDescription = spellDescription
        self.currentLevel = currentLevel
        self.isUnlocked = isUnlocked
        self.manaCost = SpellLevel.novice.manaCost
        self.icon = icon
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

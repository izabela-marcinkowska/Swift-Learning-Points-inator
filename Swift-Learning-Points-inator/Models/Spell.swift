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
    
    static func level(for mana: Int) -> SpellLevel {
        let levels = SpellLevel.allCases.reversed()
        for level in levels {
            if mana >= level.manaCost {
                return level
            }
        }
        return .novice
    }
}

extension SpellLevel {
    var bonusMultiplier: Double {
        SpellConfiguration.BonusValues.getBonus(for: self)
    }
}

extension SpellLevel {
    var bonusDescription: String {
        let percentage = bonusMultiplier * 100
        return String(format: "+%.0f%%", percentage)
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
    var investedMana: Int
    var icon: String
    var categoryRaw: String
    
    var currentSpellLevel: SpellLevel {
        SpellLevel.level(for: investedMana)
    }
    
    var currentLevel: Int {
        currentSpellLevel.rawValue
    }
    
    
    var category: SpellCategory {
        get {
            SpellCategory(rawValue: categoryRaw) ?? .focus
        }
        set {
            categoryRaw = newValue.rawValue
        }
    }
    
    init(
        name: String,
        spellDescription: String,
        category: SpellCategory = .focus,
        icon: String,
        investedMana: Int = 0
    ) {
        self.name = name
        self.spellDescription = spellDescription
        self.investedMana = investedMana
        self.icon = icon
        self.categoryRaw = category.rawValue
    }
    
    func investMana(amount: Int, from user: User) -> Bool {
        guard amount <= user.mana else { return false }
        
        user.mana -= amount
        investedMana += amount
        
        return true
    }
}

extension Spell {
    var affectedSchool: SchoolOfMagic? {
        SpellConfiguration.SchoolMapping.getAffectedSchool(for: category)
    }
}

extension Spell {
    var bonusDescription: String {
        guard let school = affectedSchool else { return "No bonus" }
        return "\(currentSpellLevel.bonusDescription) for \(school.rawValue)"
    }
}

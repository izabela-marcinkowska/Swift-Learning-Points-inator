//
//  Spell.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-28.
//

import Foundation
import SwiftData

/// Represents the mastery level of a spell, determining its power and mana cost.
/// Each level requires progressively more mana investment to achieve.
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
    
    /// Amount of mana required to achieve this level
    var manaCost: Int {
        switch self {
        case .novice: return 0
        case .adept: return 200
        case .expert: return 500
        case .master: return 1000
        }
    }
    
    /// Based on the amount mana user have collected for a spell, it returns level of that Spell.
    /// - Parameter mana: Amount mana user have collected for the Spell
    /// - Returns: ``SpellLevel`` - Level the Spell is currently on. `novice, adept, expert ` or ` master`.
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
    /// Computed property that uses SpellConfiguration to get what bonus is applied for a this Spell.
    var bonusMultiplier: Double {
        SpellConfiguration.BonusValues.getBonus(for: self)
    }
}

extension SpellLevel {
    /// Computed property containing a `String` with a user friendly description of current bonus for the Spell.
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
    
    /// Categories that are always avaliable to the user, creating core categories of the spells.
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

/// A magical ability that users can invest mana in to enhance their learning journey.
/// Spells provide bonuses to specific schools of magic and can be upgraded through
/// four levels of mastery: novice, adept, expert, and master.
@Model
class Spell {
    var name: String
    var spellDescription: String
    var investedMana: Int
    var icon: String
    var categoryRaw: String
    var lastLevelUpdate: Date?
    
    /// The current level of the spell based on invested mana
    var currentSpellLevel: SpellLevel {
        SpellLevel.level(for: investedMana)
    }
    
    /// Raw integer value of the current spell level (1-4)
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
        investedMana: Int = 0,
        lastLevelUpdate: Date? = nil
    ) {
        self.name = name
        self.spellDescription = spellDescription
        self.investedMana = investedMana
        self.icon = icon
        self.categoryRaw = category.rawValue
        self.lastLevelUpdate = lastLevelUpdate
    }
    
    /// Function is used to remove users collected mana and spend it on selected Spell.
    /// - Parameters:
    ///   - amount: Amount mana user want to invest into a Spell
    ///   - user: Mana of which user will be invested.
    /// - Returns: `true` if user have enough mana to invest and investment finished with a success, `false` if amount mana is higher than mana user have.
    func investMana(amount: Int, from user: User) -> Bool {
        guard amount <= user.mana else { return false }
        
        let currentLevel = currentSpellLevel
        
        user.mana -= amount
        investedMana += amount
        
        if currentSpellLevel != currentLevel {
            lastLevelUpdate = Date()
        }
        
        return true
    }
}

extension Spell {
    /// Returns the School of Magic that this spell provides bonuses for.
    /// For example, a Focus Enhancement spell might affect the Arcane Studies school.
    /// - Returns: The associated SchoolOfMagic if one exists, nil if the spell category has no associated school.
    var affectedSchool: SchoolOfMagic? {
        SpellConfiguration.SchoolMapping.getAffectedSchool(for: category)
    }
}

extension Spell {
    /// Provides a human-readable description of the spell's current bonus effect.
    /// For example: "+10% for Data Sorcery" or "No bonus" if the spell has no associated school.
    /// - Returns: A formatted string describing the bonus percentage and affected school.
    var bonusDescription: String {
        guard let school = affectedSchool else { return "No bonus" }
        return "\(currentSpellLevel.bonusDescription) for \(school.rawValue)"
    }
}

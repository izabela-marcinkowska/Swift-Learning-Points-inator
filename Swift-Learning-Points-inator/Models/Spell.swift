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
    
    var imageName: String {
        switch self {
        case .novice: return "novice"
        case .adept: return "adept"
        case .expert: return "expert"
        case .master: return "master"
        }
    }
    
    /// Amount of mana required to achieve this level
    var manaCost: Int {
        switch self {
        case .novice: return 0
        case .adept: return 500
        case .expert: return 1500
        case .master: return 4000
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

extension SpellLevel {
    /// Calculates mana needed to reach this level from the given current mana
    func manaNeededFrom(currentMana: Int) -> Int {
        return max(0, self.manaCost - currentMana)
    }
    
    /// Determines if this level would be achieved with the given mana
    func isAchieved(withMana mana: Int) -> Bool {
        return mana >= self.manaCost
    }
}

enum SpellCategory: String, CaseIterable {
    case steadyPractice = "Steady Practice"
    case focusedClarity = "Focused Clarity"
    case mindfulRenewal = "Mindful Renewal"
    case balancedHarmony = "Balanced Harmony"
    case resilientResolve = "Resilient Resolve"
    
    
    case seasonal = "Seasonal Spells"
    case event = "Event Spells"
    case achievement = "Achievement Spells"
    
    /// Categories that are always avaliable to the user, creating core categories of the spells.
    static let coreCategories: Set<SpellCategory> = [
        .steadyPractice, .focusedClarity, .mindfulRenewal, .balancedHarmony, .resilientResolve
    ]
    
    var isPermanent: Bool {
        SpellCategory.coreCategories.contains(self)
    }
    
    var icon: String {
        switch self {
        case .steadyPractice:
            return "clock.fill"
        case .focusedClarity:
            return "eye.fill"
        case .mindfulRenewal:
            return "leaf.fill"
        case .balancedHarmony:
            return "circle.grid.cross.fill"
        case .resilientResolve:
            return "shield.fill"
        case .seasonal:
            return "snowflake"
        case .event:
            return "star.circle"
        case .achievement:
            return "trophy"
        }
    }
    
    var imageName: String {
        switch self {
        case .steadyPractice: return "steady-practice"
        case .focusedClarity: return "focused-clarity"
        case .mindfulRenewal: return "mindful-renewal"
        case .balancedHarmony: return "balanced-harmony"
        case .resilientResolve: return "resilient-resolve"
        case .seasonal: return "seasonal"
        case .event: return "event"
        case .achievement: return "achievement"
        }
    }
    
    var description: String {
        switch self {
        case .steadyPractice:
            return "If you need a boost to keep up your daily SwiftUI practice, these spells will help you stay consistent."
        case .focusedClarity:
            return "When you need help zeroing in on tricky details, these spells will clear your mind and sharpen your focus."
        case .mindfulRenewal:
            return "If you’re feeling drained, these spells will invite you to take a restorative break and recharge."
        case .balancedHarmony:
            return "Struggling to balance work and rest? These spells support a steady, healthy work-life flow."
        case .resilientResolve:
            return "When challenges arise, these spells will fortify your determination and keep you moving forward."
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
    var imageName: String
    
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
            SpellCategory(rawValue: categoryRaw) ?? .steadyPractice
        }
        set {
            categoryRaw = newValue.rawValue
        }
    }
    
    init(
        name: String,
        spellDescription: String,
        category: SpellCategory = .steadyPractice,
        icon: String,
        investedMana: Int = 0,
        lastLevelUpdate: Date? = nil,
        imageName: String = ""
    ) {
        self.name = name
        self.spellDescription = spellDescription
        self.investedMana = investedMana
        self.icon = icon
        self.categoryRaw = category.rawValue
        self.lastLevelUpdate = lastLevelUpdate
        self.imageName = imageName
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
    /// Returns the Schools of Magic that this spell provides bonuses for.
    /// For example, a Focused Clarity spell might affect multiple schools.
    var affectedSchools: [SchoolOfMagic] {
        SpellConfiguration.SchoolMapping.getAffectedSchools(for: category) ?? []
    }
    
    /// A user-friendly bonus description for the spell.
    /// Combines the bonus multiplier and names of affected schools.
    var bonusDescription: String {
        let bonus = currentSpellLevel.bonusDescription
        let schools = affectedSchools.map { $0.rawValue }.joined(separator: ", ")
        return bonus.isEmpty ? "No bonus" : "\(bonus) for \(schools)"
    }
}

extension Spell {
    /// Returns the next level for this spell if it exists
    var nextSpellLevel: SpellLevel? {
        guard currentLevel < SpellLevel.master.rawValue else {
            return nil
        }
        return SpellLevel(rawValue: currentLevel + 1)
    }
    
    /// Calculates the normalized progress (0-1) towards the next level
    var progressToNextLevel: Double {
        guard let nextLevel = nextSpellLevel else {
            return 1.0 // Already at max level
        }
        
        let currentLevelObj = currentSpellLevel
        let currentLevelMana = currentLevelObj.manaCost
        let nextLevelMana = nextLevel.manaCost
        
        let manaForNextLevel = nextLevelMana - currentLevelMana
        let currentProgress = investedMana - currentLevelMana
        
        return manaForNextLevel > 0 ?
            min(max(Double(currentProgress) / Double(manaForNextLevel), 0), 1) : 0
    }
    
    /// Amount of mana needed to reach the next level
    var manaNeededForNextLevel: Int {
        guard let nextLevel = nextSpellLevel else {
            return 0 // Already at max level
        }
        
        return max(0, nextLevel.manaCost - investedMana)
    }
    
    /// Returns appropriate text for displaying mana progress
    var manaProgressText: String {
        if let nextLevel = nextSpellLevel {
            return "\(investedMana)/\(nextLevel.manaCost)"
        } else {
            return "\(investedMana)" // Already at max level
        }
    }
    
    /// Predicts the level that would be achieved with additional mana
    func predictedLevel(withAdditionalMana additionalMana: Int) -> SpellLevel {
        return SpellLevel.level(for: investedMana + additionalMana)
    }
    
    /// Checks if investing additional mana would cause a level up
    func wouldLevelUp(withAdditionalMana additionalMana: Int) -> Bool {
        let newLevel = predictedLevel(withAdditionalMana: additionalMana)
        return newLevel.rawValue > currentSpellLevel.rawValue
    }
    
    /// Calculates remaining mana needed after a hypothetical investment
    func remainingManaForNextLevel(afterInvesting additionalMana: Int) -> Int {
        let predictedLvl = predictedLevel(withAdditionalMana: additionalMana)
        guard predictedLvl != .master else { return 0 }
        
        let nextLevel = SpellLevel(rawValue: predictedLvl.rawValue + 1) ?? .master
        return nextLevel.manaCost - (investedMana + additionalMana)
    }
    
    /// Text to display about level progress for a specific level
    func getLevelStatusText(for level: SpellLevel) -> String {
        if level.rawValue < currentLevel {
            return "Level unlocked"
        } else if level.rawValue == currentLevel {
            if level == .master {
                return "Maximum level achieved"
            } else if let nextLevel = nextSpellLevel {
                let manaNeeded = manaNeededForNextLevel
                return "For \(nextLevel.title), need \(manaNeeded) more mana"
            }
        } else {
            // For future levels
            let manaNeeded = level.manaNeededFrom(currentMana: investedMana)
            return "Need \(manaNeeded) more mana to unlock"
        }
        
        return ""
    }
}

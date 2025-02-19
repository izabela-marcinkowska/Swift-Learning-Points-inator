//
//  SpellConfiguration.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-10.
//

import Foundation

/// Configuration for spell system mechanics, including school mappings and bonus calculations.
/// This enum serves as a namespace for spell-related configuration and relationships.
enum SpellConfiguration {
    /// Manages the relationships between spell categories and schools of magic.
    /// This structure defines which spell categories provide bonuses to which schools,
    /// allowing for cross-category enhancement effects.
    struct SchoolMapping {
        /// Defines which school of magic is enhanced by each spell category.
        /// For example, Focus spells enhance Arcane Studies tasks.
        static let categoryToSchools: [SpellCategory: [SchoolOfMagic]] = [
            .steadyPractice: [.stateSorcery, .xcodeArcana],
            .focusedClarity: [.viewAlchemy, .accessibilityArcanum],
            .mindfulRenewal: [.temporalConjurations, .fileDivination],
            .balancedHarmony: [.everydayEndeavors, .layoutLegends],
            .resilientResolve: [.qualityConjurations, .animationEnchantments, .gestureMysticism]
        ]
        
        /// Finds which school of magic is enhanced by a given spell category.
        /// - Parameter category: The spell category to check
        /// - Returns: The school of magic that receives bonuses from this category, if any
        static func getAffectedSchools(for category: SpellCategory) -> [SchoolOfMagic]? {
            return categoryToSchools[category]
        }
        
        /// Finds all spell categories that enhance a specific school of magic.
        /// - Parameter school: The school of magic to check
        /// - Returns: Array of spell categories that provide bonuses to this school
        static func getAffectingCategories(for school: SchoolOfMagic) -> [SpellCategory] {
            return categoryToSchools.filter { $0.value.contains(school) }.map { $0.key }
        }
    }
}

extension SpellConfiguration {
    /// Defines the bonus multipliers for different spell levels.
    /// These values determine how much additional mana a spell provides
    /// to tasks in its affected school.
    struct BonusValues {
        static let levelBonuses: [SpellLevel: Double] = [
            .novice: 0.0,
            .adept: 0.10,
            .expert: 0.15,
            .master: 0.20
        ]
        
        /// Retrieves the bonus multiplier for a given spell level.
        /// - Parameter level: The spell level to get the bonus for
        /// - Returns: The bonus multiplier for the given level, defaulting to 0.0 if not found
        static func getBonus(for level: SpellLevel) -> Double {
            levelBonuses[level] ?? 0.0
        }
    }
}

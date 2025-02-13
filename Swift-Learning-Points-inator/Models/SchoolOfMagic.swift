//
//  SchoolOfMagic.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-14.
//

import Foundation

/// Represents the different schools of magic in the learning system.
/// Each school focuses on a different aspect of programming, themed as magical disciplines.
enum SchoolOfMagic: String, CaseIterable {
    /// Focuses on UI/UX development and interface design
    case interfaceEnchantments = "Interface Enchantments"
    
    /// Concentrates on data management and persistence
    case dataSorcery = "Data Sorcery"
    
    /// Deals with async programming and timing operations
    case temporalMagic = "Temporal Magic"
    
    /// Covers view modifications and transformations
    case transformationSpells = "Transformation Spells"
    
    /// Encompasses fundamental programming concepts
    case arcaneStudies = "Arcane Studies"
    
    /// SF Symbol icon representing this school of magic
    var icon: String {
        switch self {
        case .interfaceEnchantments:
            return "wand.and.rays"
        case .dataSorcery:
            return "cylinder.split.1x2.fill"
        case .temporalMagic:
            return "hourglass"
        case .transformationSpells:
            return "sparkles.square.filled.on.square"
        case .arcaneStudies:
            return "books.vertical.fill"
        }
    }
    
    /// Detailed description of what this school of magic teaches
    var description: String {
        switch self {
        case .interfaceEnchantments:
            return "Master the art of crafting beautiful and intuitive magical interfaces"
        case .dataSorcery:
            return "Learn to manipulate and store magical data with powerful spells"
        case .temporalMagic:
            return "Control the flow of time in your applications"
        case .transformationSpells:
            return "Transform views with powerful modification enchantments"
        case .arcaneStudies:
            return "Explore the fundamental theories of magical programming"
        }
    }
    
    /// Represents achievement levels that can be attained within each school of magic.
    /// Users progress through these levels by earning mana in school-specific tasks.
    enum AchievementLevel: Int, CaseIterable {
        case apprentice = 0
        case mage = 1
        case archmage = 2
        case grandSorcerer = 3
        
        var title: String {
            switch self {
            case .apprentice: return "Apprentice"
            case .mage: return "Mage"
            case .archmage: return "Archmage"
            case .grandSorcerer: return "Grand Sorcerer"
            }
        }
        
        /// The amount of mana required to reach this level
        var manaThreshold: Int {
            switch self {
            case .apprentice: return 0
            case .mage: return 300
            case .archmage: return 1000
            case .grandSorcerer: return 2500
            }
        }
        
        /// Determines the achievement level based on accumulated mana
        /// - Parameter mana: Total mana accumulated in the school
        /// - Returns: The highest achievement level reached with this amount of mana
        static func level(for mana: Int) -> AchievementLevel {
            let levels = AchievementLevel.allCases.reversed()
            for level in levels {
                if mana >= level.manaThreshold {
                    return level
                }
            }
            return .apprentice
        }
    }
    
    /// Creates a formatted title combining the achievement level and school specialization
    /// - Parameter level: The achievement level to create the title for
    /// - Returns: A formatted string like "Archmage of Data Sorcery"
    func titleForLevel(_ level: AchievementLevel) -> String {
        switch self {
        case .interfaceEnchantments:
            return "\(level.title) of Interface Magic"
        case .dataSorcery:
            return "\(level.title) of Data Sorcery"
        case .temporalMagic:
            return "\(level.title) of Time"
        case .transformationSpells:
            return "\(level.title) of Transformation"
        case .arcaneStudies:
            return "\(level.title) of Arcane Knowledge"
        }
    }
    
}

//
//  SchoolOfMagic.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-14.
//

import Foundation

enum SchoolOfMagic: String, CaseIterable {
    case interfaceEnchantments = "Interface Enchantments"
    case dataSorcery = "Data Sorcery"
    case temporalMagic = "Temporal Magic"
    case transformationSpells = "Transformation Spells"
    case arcaneStudies = "Arcane Studies"
    
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
        
        var manaThreshold: Int {
            switch self {
            case .apprentice: return 0
            case .mage: return 300
            case .archmage: return 1000
            case .grandSorcerer: return 2500
            }
        }
        
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

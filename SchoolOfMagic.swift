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
}

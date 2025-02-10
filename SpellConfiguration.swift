//
//  SpellConfiguration.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-10.
//

import Foundation


enum SpellConfiguration {
    struct SchoolMapping {
        static let categoryToSchool: [SpellCategory: SchoolOfMagic] = [
            .focus: .arcaneStudies,
            .clarity: .dataSorcery,
            .balance: .interfaceEnchantments,
            .perseverance: .temporalMagic,
            .restoration: .transformationSpells
        ]
        
        static func getAffectedSchool(for category: SpellCategory) -> SchoolOfMagic? {
            categoryToSchool[category]
        }
        
        static func getAffectingCategories(for school: SchoolOfMagic) -> [SpellCategory] {
            categoryToSchool.filter {$0.value == school }.map(\.key)
        }
    }
}

extension SpellConfiguration {
    struct BonusValues {
        static let levelBonuses: [SpellLevel: Double] = [
            .novice: 0.0,
            .adept: 0.10,
            .expert: 0.20,
            .master: 0.35
        ]
        
        static func getBonus(for level: SpellLevel) -> Double {
            levelBonuses[level] ?? 0.0
        }
    }
}

//
//  ManaCalculator.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-10.
//

import Foundation

enum ManaCalculator {
    struct ManaBreakdown {
        let baseMana: Int
        let bonuses: [(spell: Spell, amount: Int)]
        
        var totalBonus: Int {
            bonuses.reduce(0) { $0 + $1.amount }
        }
        
        var total: Int {
            baseMana + totalBonus
        }
    }
    
    static func calculateMana(for task: Task, user: User, spells: [Spell]) -> ManaBreakdown {
        let baseMana = task.mana
        
        let spellBonuses = spells.compactMap { spell -> (Spell, Int)? in
            let bonusAmount = calculateSpellBonus(
                spell: spell,
                forSchool: task.school,
                baseMana: baseMana
            )
            return bonusAmount > 0 ? (spell, bonusAmount) : nil
        }
        
        return ManaBreakdown(
            baseMana: baseMana,
            bonuses: spellBonuses
        )
    }
    
    
    private static func calculateSpellBonus(spell: Spell, forSchool school: SchoolOfMagic, baseMana: Int) -> Int {
        guard spell.affectedSchool == school else { return 0 }
        
        let multiplier = spell.currentSpellLevel.bonusMultiplier
        
        let bonusAsDouble = Double(baseMana) * multiplier
        return Int(bonusAsDouble.rounded())
    }
}

//
//  ManaCalculator.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-10.
//

import Foundation

/// Calculates and breaks down mana rewards for completed tasks, including spell bonuses.
/// This calculator considers both the base mana value of a task and any applicable spell bonuses
/// that might increase the reward.
enum ManaCalculator {
    
    /// Provides a detailed breakdown of mana rewards for a completed task.
    /// This structure separates the base mana value from any spell-based bonuses,
    /// allowing for transparent reward calculations.
    ///
    /// - `baseMana` - rough amount mana the task contains
    /// - `bonuses` - list of the spells and amount bonuses
    /// - `totalBonus`- total amount bonus this task produce
    /// - `total`- base mana plus all of the bonuses
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
    
    /// Calculates the total mana reward for completing a task, including any applicable spell bonuses.
    /// - Parameters:
    ///   - task: The ``Task`` being completed
    ///   - user: The ``User``completing the task
    ///   - spells: Array of Available spells that might provide bonuses
    /// - Returns: ``ManaBreakdown`` A breakdown of the mana reward, including base value and all applicable bonuses
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
    
    
    /// Calculates the bonus mana provided by a single spell for a specific school.
    /// - Parameters:
    ///   - spell: ``Spell`` to check for bonuses
    ///   - school: The school of magic the task belongs to
    ///   - baseMana: The base mana value to calculate the bonus from
    /// - Returns: The amount of bonus mana this spell provides, or 0 if the spell doesn't affect this school
    private static func calculateSpellBonus(spell: Spell, forSchool school: SchoolOfMagic, baseMana: Int) -> Int {
        guard spell.affectedSchools.contains(school) else { return 0 }
        
        let multiplier = spell.currentSpellLevel.bonusMultiplier
        let bonusAsDouble = Double(baseMana) * multiplier
        return Int(bonusAsDouble.rounded())
    }
}

//
//  SampleSpells.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation


enum SampleSpells {
    static let focusSpells: [Spell] = [
        // Focus Enhancement Spells
        Spell(
            name: "Mind Sharpening Charm",
            spellDescription: "A fundamental spell that enhances your ability to concentrate during coding sessions. As you upgrade it, your focus periods become more effective.",
            category: .focus,
            icon: "brain.fill",
            investedMana: 150
        ),
        Spell(
            name: "Distraction Ward",
            spellDescription: "Creates a magical barrier against distractions while you're deep in code. Higher levels strengthen this protective enchantment.",
            category: .focus,
            icon: "shield.fill",
            investedMana: 560
        ),
        Spell(
            name: "Time Dilation Spell",
            spellDescription: "Makes your study time feel more productive by helping you enter a state of flow. Upgrading deepens this temporal enhancement.",
            category: .focus,
            icon: "hourglass.circle.fill"
        )]
    static let restorationSpells: [Spell] = [
        
        // Restoration Spells
        Spell(
            name: "Energy Renewal Charm",
            spellDescription: "Enhances the effectiveness of your coding breaks. Higher levels provide more rejuvenation during rest periods.",
            category: .restoration,
            icon: "bolt.circle.fill"
        ),
        Spell(
            name: "Rest Ritual",
            spellDescription: "Establishes magical patterns for regular breaks. Upgrading helps create better rest habits.",
            category: .restoration,
            icon: "moon.stars.fill"
        ),
        Spell(
            name: "Refreshment Enchantment",
            spellDescription: "Quick energy restoration between coding sessions. More powerful versions provide deeper refreshment.",
            category: .restoration,
            icon: "leaf.fill"
        )]
        
    static let balanceSpells: [Spell] = [
        // Balance Spells
        Spell(
            name: "Harmony Weaver",
            spellDescription: "Helps maintain balance between coding practice and rest. Higher levels create stronger harmony.",
            category: .balance,
            icon: "yin.yang"
        ),
        Spell(
            name: "Boundary Guardian",
            spellDescription: "Assists in setting healthy limits on coding sessions. Upgrading strengthens your time boundaries.",
            category: .balance,
            icon: "clock.badge.checkmark.fill"
        ),
        Spell(
            name: "Flow Stabilizer",
            spellDescription: "Maintains steady progress in your learning journey. Enhanced versions provide more stable progress patterns.",
            category: .balance,
            icon: "waveform.path"
        )]
        
    static let claritySpells: [Spell] = [
        // Clarity Spells
        Spell(
            name: "Concept Crystallization",
            spellDescription: "Makes complex coding concepts easier to grasp. Higher levels enhance your understanding.",
            category: .clarity,
            icon: "sparkles.square.filled.on.square"
        ),
        Spell(
            name: "Error Insight Charm",
            spellDescription: "Improves your ability to understand and fix bugs. Upgrading deepens your debugging intuition.",
            category: .clarity,
            icon: "magnifyingglass.circle.fill"
        ),
        Spell(
            name: "Pattern Recognition Spell",
            spellDescription: "Helps identify common coding patterns. More powerful versions enhance pattern recognition.",
            category: .clarity,
            icon: "square.grid.3x3.fill"
        )]
        
    static let perseveranceSpells: [Spell] = [
        // Perseverance Spells
        Spell(
            name: "Debug Fortitude",
            spellDescription: "Strengthens your resilience during debugging sessions. Higher levels provide greater endurance.",
            category: .perseverance,
            icon: "hammer.circle.fill"
        ),
        Spell(
            name: "Challenge Crusher",
            spellDescription: "Boosts confidence when facing difficult coding tasks. Upgrading enhances your problem-solving spirit.",
            category: .perseverance,
            icon: "mountain.2.fill"
        ),
        Spell(
            name: "Progress Momentum",
            spellDescription: "Helps maintain motivation in your coding journey. More powerful versions create stronger momentum.",
            category: .perseverance,
            icon: "arrow.up.forward.circle.fill"
        )]
    
    static let seasonalSpells: [Spell] = [
        // Seasonal Spell Example
        Spell(
            name: "Winter's Focus",
            spellDescription: "A seasonal enchantment that brings the clarity of winter frost to your coding practice. Available during winter months.",
            category: .seasonal,
            icon: "snowflake"
        )
    ]
    
    static var allSpells: [Spell] {
        return focusSpells + restorationSpells + balanceSpells + claritySpells + perseveranceSpells + seasonalSpells
    }
}

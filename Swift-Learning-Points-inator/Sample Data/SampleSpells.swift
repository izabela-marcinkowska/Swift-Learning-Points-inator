//
//  SampleSpells.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation


enum SampleSpells {
    // Steady Practice Spells
    static let steadyPracticeSpells: [Spell] = [
        Spell(
            name: "Spell of Consistent Effort",
            spellDescription: "If you need a boost in keeping up with your daily SwiftUI practice, try this spell to help maintain your momentum.",
            category: .steadyPractice,
            icon: "clock.fill",
            investedMana: 0,
            imageName: "consistent-effort"
        ),
        Spell(
            name: "Charm of Daily Discipline",
            spellDescription: "When you feel your focus slipping, use this charm to reinforce a regular coding schedule and stay on track.",
            category: .steadyPractice,
            icon: "calendar",
            investedMana: 0,
            imageName: "daily-discipline"
        ),
        Spell(
            name: "Incantation of Routine Resilience",
            spellDescription: "If you ever struggle to stick with your tasks, cast this incantation to strengthen your resolve and keep your routine strong.",
            category: .steadyPractice,
            icon: "flame.fill",
            investedMana: 0,
            imageName: "routine-resilience"
        )
    ]
    
    // Focused Clarity Spells
    static let focusedClaritySpells: [Spell] = [
        Spell(
            name: "Charm of Clear Vision",
            spellDescription: "When you need to see the finer details in your code, let this charm clear your mind and enhance your focus.",
            category: .focusedClarity,
            icon: "eye.fill",
            investedMana: 0,
            imageName: "clear-vision"
        ),
        Spell(
            name: "Ritual of Insightful Focus",
            spellDescription: "If you’re tackling a tricky concept, this ritual will help illuminate the path forward and boost your understanding.",
            category: .focusedClarity,
            icon: "lightbulb.fill",
            investedMana: 0,
            imageName: "insightful-focus"
        ),
        Spell(
            name: "Beacon of Lucid Thought",
            spellDescription: "Cast this beacon when you need guidance through challenging coding problems, lighting up the way with clarity.",
            category: .focusedClarity,
            icon: "sparkles",
            investedMana: 0,
            imageName: "lucid-thought"
        )
    ]
    
    // Mindful Renewal Spells
    static let mindfulRenewalSpells: [Spell] = [
        Spell(
            name: "Elixir of Refreshment",
            spellDescription: "If you’re feeling drained, sip on this elixir to refresh your mind and boost your energy for more SwiftUI adventures.",
            category: .mindfulRenewal,
            icon: "leaf.fill",
            investedMana: 0,
            imageName: "refreshment"
        ),
        Spell(
            name: "Brew of Restorative Calm",
            spellDescription: "When the pressure builds up, this brew can help you find calm and balance, easing your way back to productivity.",
            category: .mindfulRenewal,
            icon: "cup.and.saucer",
            investedMana: 0,
            imageName: "restorative-calm"
        ),
        Spell(
            name: "Potion of Rejuvenated Spirit",
            spellDescription: "For those moments when you need to recharge after a tough session, this potion will lift your spirits and get you back in the game.",
            category: .mindfulRenewal,
            icon: "drop.fill",
            investedMana: 0,
            imageName: "rejuvenated-spirit"
        )
    ]
    
    // Balanced Harmony Spells
    static let balancedHarmonySpells: [Spell] = [
        Spell(
            name: "Talisman of Equilibrium",
            spellDescription: "If you’re struggling to juggle your work and downtime, let this talisman help you find balance in your daily routine.",
            category: .balancedHarmony,
            icon: "circle.grid.cross.fill",
            investedMana: 0,
            imageName: "equilibrium"
        ),
        Spell(
            name: "Amulet of Serenity",
            spellDescription: "When stress creeps in, wear this amulet to restore your calm and keep you centered throughout your coding journey.",
            category: .balancedHarmony,
            icon: "sun.max.fill",
            investedMana: 0,
            imageName: "serenity"
        ),
        Spell(
            name: "Sigil of Harmonious Flow",
            spellDescription: "If you need a smoother ride through your SwiftUI tasks, cast this sigil to encourage a natural, steady flow of progress.",
            category: .balancedHarmony,
            icon: "waveform.path",
            investedMana: 0,
            imageName: "harmonious-flow"
        )
    ]
    
    // Resilient Resolve Spells
    static let resilientResolveSpells: [Spell] = [
        Spell(
            name: "Charm of Unyielding Will",
            spellDescription: "When you’re faced with tough problems, this charm can empower you with the determination to keep pushing forward.",
            category: .resilientResolve,
            icon: "shield.fill",
            investedMana: 0,
            imageName: "unyielding-will"
        ),
        Spell(
            name: "Incantation of Persistent Courage",
            spellDescription: "If the obstacles seem insurmountable, recite this incantation to ignite your inner strength and courage.",
            category: .resilientResolve,
            icon: "bolt.fill",
            investedMana: 0,
            imageName: "persistent-courage"
        ),
        Spell(
            name: "Blessing of Steadfast Fortitude",
            spellDescription: "For those moments when you need a burst of resilience, this blessing will reinforce your spirit and keep you on course.",
            category: .resilientResolve,
            icon: "tree.fill",
            investedMana: 0,
            imageName: "fortitude"
        )
    ]
    
    static var allSpells: [Spell] {
        return steadyPracticeSpells +
               focusedClaritySpells +
               mindfulRenewalSpells +
               balancedHarmonySpells +
               resilientResolveSpells
    }
}

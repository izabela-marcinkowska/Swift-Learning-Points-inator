//
//  SpellBonusesView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-04.
//

import SwiftUI

struct SpellBonusesView: View {
    let spell: Spell
    
    private var progressToNextLevel: Double {
            spell.progressToNextLevel
        }
    
    var body: some View {
        let levels = Array(SpellLevel.allCases.enumerated())
        let nextLevelToAchieve = spell.nextSpellLevel ?? .master
        
        VStack(alignment: .leading, spacing: 16) {
            ForEach(levels, id: \.element) { index, level in
                SpellLevelRow(
                    level: level,
                    isAchieved: spell.investedMana >= level.manaCost,
                    isCurrent: level == nextLevelToAchieve,
                    progressValue: level == nextLevelToAchieve ? progressToNextLevel : 0,
                    spell: spell,
                    showDivider: index < levels.count - 1
                )
            }
        }
        .padding()
        .withCardStyle(useGradient: false)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

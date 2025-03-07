//
//  SpellCardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-20.
//

import SwiftUI

struct SpellCardView: View {
    let spell: Spell
    
    /// Progress toward next level, using centralized calculation from Spell model
    private var progressToNextLevel: Double {
        spell.progressToNextLevel
    }
    
    /// Mana required for next level, or current mana if at maximum level
    private var nextLevelMana: Int {
        if let nextLevel = spell.nextSpellLevel {
            return nextLevel.manaCost
        }
        return spell.investedMana
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack {
                Text(spell.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 2)
            }
            HStack(alignment: .top, spacing: 16) {
                Image(spell.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(spell.currentSpellLevel.title)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        ProgressView(value: progressToNextLevel)
                            .progressViewStyle(.linear)
                            .tint(Color("progress-color"))
                        
                        Text("\(spell.investedMana)/\(nextLevelMana)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            if !spell.bonusDescription.isEmpty {
                Text(spell.bonusDescription)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .withCardStyle(useGradient: false)
    }
}

//
//  SpellCardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-20.
//

import SwiftUI

struct SpellCardView: View {
    let spell: Spell
    
    private var progressToNextLevel: Double {
        guard spell.currentLevel < SpellLevel.master.rawValue else {
            return 1.0
        }
        
        let nextLevel = SpellLevel(rawValue: spell.currentLevel + 1) ?? .novice
        let currentLevel = SpellLevel(rawValue: spell.currentLevel) ?? .novice
        
        let currentLevelMana = currentLevel.manaCost
        let nextLevelMana = nextLevel.manaCost
        
        let manaForNextLevel = nextLevelMana - currentLevelMana
        let currentProgress = spell.investedMana - currentLevelMana
        
        return min(max(Double(currentProgress) / Double(manaForNextLevel), 0), 1)
    }
    
    private var nextLevelMana: Int {
        if spell.currentLevel >= SpellLevel.master.rawValue {
            return spell.investedMana
        }
        let nextLevel = SpellLevel(rawValue: spell.currentLevel + 1) ?? .novice
        return nextLevel.manaCost
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
        .background(Color("card-background"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

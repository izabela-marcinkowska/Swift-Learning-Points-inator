//
//  SpellCardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-20.
//

import SwiftUI

struct SpellCardView: View {
    let spell: Spell
    @Binding var showInvestSheet: Bool
    @State private var selectedSpell: Spell?
    
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
        HStack(alignment: .top, spacing: 16) {
            Image(spell.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(spell.name)
                    .font(.headline)
                
                Text(spell.currentSpellLevel.title)
                    .font(.subheadline)
                
                HStack {
                    ProgressView(value: progressToNextLevel)
                        .progressViewStyle(.linear)
                    
                    Text("\(spell.investedMana)/\(nextLevelMana)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if !spell.bonusDescription.isEmpty {
                    Text(spell.bonusDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                selectedSpell = spell
                showInvestSheet = true
            } label: {
                Text("Invest")
                    .font(.callout.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color("card-background"))
        .cornerRadius(12)
    }
}

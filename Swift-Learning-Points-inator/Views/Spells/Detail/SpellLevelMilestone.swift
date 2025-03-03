//
//  SpellLevelMilestone.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-12.
//

import SwiftUI

struct SpellLevelMilestone: View {
    let level: SpellLevel
    let isArchieved: Bool
    let isCurrent: Bool
    let progressValue: Double
    let spell: Spell
    
    private var manaNeededToUnlock: Int {
        max(0, level.manaCost - spell.investedMana)
    }
    
    private var levelSpecificBonus: String {
        let bonusPercentage = level.bonusMultiplier * 100
        
        if bonusPercentage <= 0 {
            return "No bonus"
        }
        
        let affectedSchools = spell.affectedSchools
        if affectedSchools.isEmpty {
            return "No affected schools"
        }
        
        let schoolNames = affectedSchools.map {$0.rawValue }.joined(separator: ", ")
        return String(format: "+%.0f%% for %@", bonusPercentage, schoolNames)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(level.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
                .grayscale(isArchieved || isCurrent ? 0.0 : 0.9)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(level.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                if level.bonusMultiplier > 0 {
                    let percentage = level.bonusMultiplier * 100
                    BonusEffectView(
                        percentage: percentage,
                        schools: spell.affectedSchools,
                        isActive: isArchieved || isCurrent
                    )
                } else {
                    Text("No bonus")
                        .font(.caption)
                        .foregroundColor(isArchieved || isCurrent ? Color("accent-color") : Color.primary)
                        .opacity(isArchieved || isCurrent ? 1.0 : 0.3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                if level == .novice {
                    Text("Starting level. No mana cost.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else if isArchieved {
                    // Only show "Level unlocked" for levels that are fully achieved
                    Text("Level unlocked")
                        .font(.caption)
                        .foregroundStyle(.green)
                } else if isCurrent {
                    // For the current level, show progress info
                    HStack(spacing: 1) {
                        Text("Requires")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Image("diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("\(manaNeededToUnlock) more mana to unlock")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    // For future levels
                    HStack(spacing: 1) {
                        Text("Requires")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Image("diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("\(manaNeededToUnlock) more mana to unlock")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                if isCurrent {
                    ProgressView(value: progressValue)
                        .progressViewStyle(.linear)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        Divider()
        .padding(.vertical, 2)
        .frame(maxWidth: .infinity)
        
        
    }
}

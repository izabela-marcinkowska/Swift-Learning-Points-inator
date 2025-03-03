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
    let spell: Spell
    
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
            Circle()
                .fill(isArchieved ? Color.blue : Color.gray.opacity(0.3))
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(level.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(levelSpecificBonus)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("\(level.manaCost) mana")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}

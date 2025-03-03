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
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(level.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(levelSpecificBonus)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("\(level.manaCost) mana")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if isCurrent {
                    ProgressView(value: progressValue)
                        .progressViewStyle(.linear)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                }
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.90)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        
        
    }
}

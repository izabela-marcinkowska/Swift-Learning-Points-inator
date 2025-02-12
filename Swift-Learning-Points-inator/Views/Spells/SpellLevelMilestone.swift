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
    
    var body: some View {
        HStack {
            Circle()
                .fill(isArchieved ? Color.blue : Color.gray.opacity(0.3))
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading) {
                Text(level.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text("\(level.manaCost) mana - \(level.bonusDescription)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
        }
    }
}

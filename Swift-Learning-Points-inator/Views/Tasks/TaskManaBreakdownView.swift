//
//  TaskManaBreakdownView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-17.
//

import SwiftUI

struct TaskManaBreakdownView: View {
    let task: Task
    let user: User?
    let spells: [Spell]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Points:")
                .font(.title2)
            
            if let user = user {
                let breakdown = task.calculateManaBreakdown(for: user, spells: spells)
                VStack(spacing: 8) {
                    Text("\(breakdown.baseMana)")
                        .font(.largeTitle)
                    
                    if !breakdown.bonuses.isEmpty {
                        VStack(spacing: 8) {
                            ForEach(breakdown.bonuses, id: \.spell.id) { bonus in
                                HStack {
                                    Image(systemName: bonus.spell.icon)
                                    Text("+\(bonus.amount)")
                                    Text("from \(bonus.spell.name)")
                                }
                                .foregroundStyle(.green)
                                .font(.subheadline)
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            Text("Total: \(breakdown.total)")
                                .font(.headline)
                        }
                    }
                }
            }
        }
        .padding()
    }
}


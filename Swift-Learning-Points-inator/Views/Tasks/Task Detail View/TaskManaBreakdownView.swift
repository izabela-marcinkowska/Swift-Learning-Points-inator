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
        if let user = user {
            let breakdown = task.calculateManaBreakdown(for: user, spells: spells)
            
            VStack(alignment: .leading, spacing: 8) {
                // Base mana
                HStack (spacing: 2) {
                    Image("diamond")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(breakdown.baseMana) base mana")
                        .font(.subheadline)
                }
                
                // Bonuses (if any)
                if !breakdown.bonuses.isEmpty {
                    ForEach(breakdown.bonuses, id: \.spell.id) { bonus in
                        HStack {
                            Image(bonus.spell.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("+\(bonus.amount) from \(bonus.spell.name)")
                                .font(.caption)
                                .foregroundColor(Color("progress-color"))
                        }
                        .padding(.horizontal, 5)
                    }
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    // Total with highlight
                    HStack {
                        Spacer()
                        Text("Total:")
                            .font(.subheadline)
                        
                        HStack (spacing: 2) {
                            
                        Image("diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("\(breakdown.total)")
                            .font(.headline)
                            .foregroundColor(.purple)
                        }
                    }
                }
            }
        }
    }
}

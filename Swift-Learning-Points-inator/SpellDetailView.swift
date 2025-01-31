//
//  SpellDetailView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-31.
//

import SwiftUI
import SwiftData

struct SpellDetailView: View {
    var spell: Spell
    @Query private var users: [User]
    
    private var user: User? {
        users.first
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: spell.icon)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text(spell.name)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Text(spell.spellDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Level \(spell.currentLevel)")
                .font(.headline)
            
            Text("Mana spent: \(spell.manaCost)")
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Bonuses:")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ForEach(1...3, id: \.self) { level in
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 20, height: 20)
                        Text("\(level * 5)% extra mana")
                    }
                }
            }
            Spacer()
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Image(systemName: "diamond.fill")
                    Text("\(user?.mana ?? 0)")
                }
            }
        }
    }
}

#Preview {
    SpellDetailView(spell: Spell(name: "Example name", spellDescription: "This will be an example description", icon: "star.fill"))
        .modelContainer(for: Spell.self, inMemory: true)
}

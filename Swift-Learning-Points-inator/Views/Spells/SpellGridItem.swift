//
//  SpellGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-30.
//

import SwiftUI
import SwiftData

struct SpellGridItem: View {
    let spell: Spell
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    private var user: User? {
        users.first
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: spell.icon)
                .font(.system(size: 32))
                .foregroundColor(.blue)
                .padding(.top, 8)
            
            VStack(spacing: 8) {
                Text(spell.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                
                Text("Level \(spell.currentLevel)")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 8)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    SpellGridItem(spell: Spell(
        name: "Test Spell",
        spellDescription: "A test spell",
        category: .steadyPractice,
        icon: "wand.and.rays"
    ))
    .modelContainer(for: [Spell.self, User.self], inMemory: true)
}

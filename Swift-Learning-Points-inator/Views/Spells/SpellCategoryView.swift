//
//  SpellCategoryView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-30.
//

import SwiftUI
import SwiftData

struct SpellCategoryView: View {
    let category: SpellCategory
    
    @Query private var allSpells: [Spell]
    @State private var showInvestSheet = false
    @State private var selectedSpell: Spell?
    
    var spells: [Spell] {
        allSpells.filter { $0.category == category }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Category header
                CategoryHeaderView(category: category)
                
                // Spells list
                VStack(spacing: 16) {
                    ForEach(spells) { spell in
                        NavigationLink {
                            SpellDetailView(spell: spell)
                        } label: {
                            SpellCardView(spell: spell, showInvestSheet: $showInvestSheet)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color("background-color"))
        .sheet(isPresented: $showInvestSheet) {
            if let spell = selectedSpell {
                AddManaSheet(spell: spell)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpellCategoryView(category: .steadyPractice)
    }
    .modelContainer(for: [Spell.self, User.self], inMemory: true)
}

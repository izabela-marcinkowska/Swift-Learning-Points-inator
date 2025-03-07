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
    
    var spells: [Spell] {
        allSpells.filter { $0.category == category }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryHeaderView(category: category)
                
                VStack(spacing: 16) {
                    ForEach(spells) { spell in
                        NavigationLink {
                            SpellDetailView(spell: spell)
                        } label: {
                            SpellCardView(spell: spell)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .withGradientBackground()
    }
}


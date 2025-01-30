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
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
    ]
    
    @Query private var allSpells: [Spell]

    var spells: [Spell] {
        allSpells.filter { $0.category == category }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(spells) { spell in
                    NavigationLink {
                        Text("Detail view comming soon")
                    } label: {
                        SpellGridItem(spell: spell)
                            .frame(height: 200)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(category.rawValue)
    }
}

#Preview {
    NavigationStack {
        SpellCategoryView(category: .focus)
    }
    .modelContainer(for: [Spell.self, User.self], inMemory: true)
}

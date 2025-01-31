//
//  SpellDetailView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-31.
//

import SwiftUI

struct SpellDetailView: View {
    var spell: Spell
    
    var body: some View {
        Text(spell.name)
        Text(spell.spellDescription)
    }
}

#Preview {
    SpellDetailView(spell: Spell(name: "Example name", spellDescription: "This will be an example description", icon: "star.fill"))
        .modelContainer(for: Spell.self, inMemory: true)
}

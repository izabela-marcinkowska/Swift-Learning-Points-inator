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
    @State private var showingAddManaSheet = false
    
    private var user: User? {
        users.first
    }
    
    var body: some View {
        VStack(spacing: 20) {
            SpellDetailViewHeader(spell: spell)
            ScrollView(.vertical, showsIndicators: false) {
                SpellBonusesView(spell: spell)
            }
            MagicalButton(
                text: "Invest Mana",
                isEnabled: true,
                action: {
                    showingAddManaSheet.toggle()
                }
            )
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(8)
        .withGradientBackground()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ManaDisplayView()
            }
        }
        .sheet(isPresented: $showingAddManaSheet) {
            AddManaSheet(spell: spell)
        }
    }
}

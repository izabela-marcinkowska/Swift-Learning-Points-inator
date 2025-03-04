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
            InvestManaButton {
                showingAddManaSheet.toggle()
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(8)
        .background(Color("background-color"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack (spacing: 1) {
                    Image("diamond")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 46, height: 46)
                    Text("\(user?.mana ?? 0)")
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .monospacedDigit()
                        .foregroundColor(.purple)
                        .shadow(color: .pink.opacity(0.3), radius: 1, x: 1, y: 1)
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .sheet(isPresented: $showingAddManaSheet) {
            AddManaSheet(spell: spell)
        }
    }
}

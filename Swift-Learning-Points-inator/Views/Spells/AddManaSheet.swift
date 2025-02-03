//
//  AddManaSheet.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-03.
//

import SwiftUI
import SwiftData

struct AddManaSheet: View {
    let spell: Spell
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [User]
    @State private var manaToInvest: Double = 0
    
    private var user: User? {
        users.first
    }
    
    private var maxInvestment: Int {
        user?.mana ?? 0
    }
    
    var body: some View {
        NavigationStack { 
            VStack(spacing: 24) {
                Text("Invest mana in:")
                    .font(.headline)
                
                Text(spell.name)
                    .font(.title)
                Spacer()
                HStack {
                    Text("0")
                    Slider(value: $manaToInvest, in: 0...Double(maxInvestment))
                        .padding(.horizontal)
                    Text("\(maxInvestment)")
                }
                
                Text("\(Int(manaToInvest)) mana selected")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    if let user = user {
                        if spell.investMana(amount: Int(manaToInvest), from: user) {
                            try? modelContext.save()
                            dismiss()
                        } else {
                            print("Failed to invest mana")
                        }
                    }
                } label: {
                    Text("Use \(Int(manaToInvest)) mana")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .disabled(manaToInvest == 0)
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.height(450)])
    }
}

#Preview {
    AddManaSheet(spell: Spell(name: "Example name", spellDescription: "This will be an example description", icon: "star.fill"))
        .modelContainer(for: Spell.self, inMemory: true)
}

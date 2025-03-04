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
    
    private var resultingLevel: SpellLevel {
        SpellLevel.level(for: spell.investedMana + Int(manaToInvest))
    }
    
    private var willLevelUp: Bool {
        resultingLevel.rawValue > spell.currentSpellLevel.rawValue
    }
    
    private var remainingManaForNextLevel: Int {
        guard resultingLevel != .master else { return 0 }
        
        let nextLevel = SpellLevel(rawValue: resultingLevel.rawValue + 1) ?? .master
        return nextLevel.manaCost - (spell.investedMana + Int(manaToInvest))
    }
    
    private func investManaAction() {
        if let user = user {
                if spell.investMana(amount: Int(manaToInvest), from: user) {
                    try? modelContext.save()
                    dismiss()
                } else {
                    print("Failed to invest mana")
                }
            }
    }
    
    var body: some View {
        NavigationStack { 
            VStack(spacing: 12) {
                Text("Invest mana in \(spell.name)")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                HStack {
                    Text("0")
                    Slider(value: $manaToInvest, in: 0...Double(maxInvestment))
                        .padding(.horizontal)
                        .tint(Color("progress-color"))
                    Text("\(maxInvestment)")
                }
                

                    VStack(alignment: .leading, spacing: 8) {
                        if willLevelUp {
                            HStack {
                                Image(resultingLevel.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("You will reach \(resultingLevel.title)!")
                                    .foregroundStyle(Color("accent-color"))
                                    .font(.subheadline)
                            }
                        } else if remainingManaForNextLevel > 0 {
                            HStack {
                                Image("diamond")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("Need \(remainingManaForNextLevel) more mana for next level")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(8)
                
                InvestManaButton(text: "Invest \(Int(manaToInvest)) mana", action: investManaAction, isEnabled: manaToInvest > 0)
                
            }
            .frame(maxHeight: .infinity)
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(Color("button-color"))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("background-color"))
        }
        .presentationDetents([.height(350)])
    }
}

#Preview {
    AddManaSheet(spell: Spell(name: "Example name", spellDescription: "This will be an example description", icon: "star.fill"))
        .modelContainer(for: Spell.self, inMemory: true)
}

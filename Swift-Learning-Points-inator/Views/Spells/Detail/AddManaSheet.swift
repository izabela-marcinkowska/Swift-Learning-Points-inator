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
    let onComplete: (SpellLevel?, Int) -> Void
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var taskNotificationManager: TaskNotificationManager
    @EnvironmentObject var toastManager: ToastManager
    
    @Query private var users: [User]
    @State private var manaToInvest: Double = 0
    
    
    private var user: User? {
        users.first
    }
    
    private var maxInvestment: Int {
        user?.mana ?? 0
    }
    
    private var resultingLevel: SpellLevel {
        spell.predictedLevel(withAdditionalMana: Int(manaToInvest))
    }
    
    private var willLevelUp: Bool {
        spell.wouldLevelUp(withAdditionalMana: Int(manaToInvest))
    }
    
    private var remainingManaForNextLevel: Int {
        spell.remainingManaForNextLevel(afterInvesting: Int(manaToInvest))
    }
    
    /// Processes the mana investment transaction between the user and spell.
    ///
    /// This function handles the complete process of investing mana in a spell:
    /// 1. Verifies the user exists
    /// 2. Attempts to transfer the specified amount of mana from user to spell
    /// 3. Saves the changes to the data context
    /// 4. Reports back whether the investment caused a level-up
    ///
    /// - Note: On success, this function will dismiss the current view
    /// - Important: The function will display appropriate error messages if the user doesn't exist or lacks sufficient mana
    private func investManaAction() {
        guard let user = user else {
            toastManager.showError(AppError.spellOperation("User data not avaliabkle."))
            return
        }
        
        let currentLevel = spell.currentSpellLevel
        let amount = Int(manaToInvest)
        
        if spell.investMana(amount: Int(manaToInvest), from: user) {
            if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "investing mana") {
                dismiss()
                if spell.currentSpellLevel != currentLevel {
                    onComplete(spell.currentSpellLevel, amount)
                } else {
                    onComplete(nil, amount)
                }
            }
        } else {
            toastManager.showError(AppError.spellOperation("Not enought mana to invest"))
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
                
                MagicalButton(
                    text: "Invest \(Int(manaToInvest)) mana",
                    isEnabled: manaToInvest > 0,
                    action: {
                        investManaAction()
                    }
                )
                
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

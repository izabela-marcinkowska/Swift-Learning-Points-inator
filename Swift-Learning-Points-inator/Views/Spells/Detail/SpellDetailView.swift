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
    
    /// Calculates the progress towards the next spell level as a value between 0 and 1.
    /// This value is used to display the progress bar in the UI.
    ///
    /// The calculation works as follows:
    /// 1. Returns 1.0 if spell is already at master level (maximum)
    /// 2. Determines current and next level mana thresholds
    /// 3. Calculates progress by comparing current mana against the thresholds
    /// 4. Normalizes the result to be between 0 and 1
    ///
    /// For example:
    /// - If current level requires 200 mana and next level 500 mana:
    /// - With 350 mana invested, progress would be 0.5 (halfway between levels)
    private var progressToNextLevel: Double {
        guard spell.currentLevel < SpellLevel.master.rawValue else {
            return 1.0
        }
        
        let nextLevel = SpellLevel(rawValue: spell.currentLevel + 1) ?? .novice
        let currentLevel = SpellLevel(rawValue: spell.currentLevel) ?? .novice
        
        let currentLevelMana = currentLevel.manaCost
        let nextLevelMana = nextLevel.manaCost
        
        let manaForNextLevel = nextLevelMana - currentLevelMana
        let currentProgress = spell.investedMana - currentLevelMana
        
        return min(max(Double(currentProgress) / Double(manaForNextLevel), 0), 1)
    }
    
    
    var body: some View {
        VStack(spacing: 20) {
            SpellDetailViewHeader(spell: spell)
            
            Text("Mana invested: \(spell.investedMana)")
            
            
            VStack(alignment: .leading, spacing: 16) {                
                ForEach(SpellLevel.allCases, id: \.self) { level in
                    let nextLevelToAchieve = SpellLevel(rawValue: spell.currentLevel + 1) ?? .master
                    SpellLevelMilestone(
                        level: level,
                        isArchieved: spell.investedMana >= level.manaCost,
                        isCurrent: level == nextLevelToAchieve,
                        progressValue: level == nextLevelToAchieve ? progressToNextLevel : 0,
                        spell: spell)
                    
                }
                
            }
            .padding()
            .background(Color("card-background"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
            .cornerRadius(10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .background(Color("background-color"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Image("mana-diamond")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text("\(user?.mana ?? 0)")
                }
            }
        }
        .sheet(isPresented: $showingAddManaSheet) {
            AddManaSheet(spell: spell)
        }
    }
}

#Preview {
    SpellDetailView(spell: Spell(name: "Example name", spellDescription: "This will be an example description", icon: "star.fill"))
        .modelContainer(for: Spell.self, inMemory: true)
}

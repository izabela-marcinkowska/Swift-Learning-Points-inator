//
//  UserCardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-30.
//

import SwiftUI
import SwiftData

struct UserCardView: View {
    let user: User
    @Query private var spells: [Spell]
    @Query private var schools: [SchoolProgress]
    
    private var masterSpellsCount: Int {
        spells.filter { $0.currentSpellLevel == .master }.count
    }
    
    private var totalSpells: Int {
        spells.count
    }
    
    private var grandSorcererSchoolsCount: Int {
        schools.filter {$0.currentLevel == .grandSorcerer }.count
    }
    
    private var totalSchools: Int {
        SchoolOfMagic.allCases.count
    }
    
    private func getHighestAchievement() -> String {
        if let highestSchool = schools.max(by: { $0.currentLevel.rawValue < $1.currentLevel.rawValue }) {
            return highestSchool.school.titleForLevel(highestSchool.currentLevel)
        }
        return "Apprentice Sorcerer"
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                Image(user.gender.avatarName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.4),
                                        Color("accent-color").opacity(0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(getHighestAchievement())
                        .font(.subheadline)
                        .foregroundColor(Color("accent-color"))
                }
                
                Spacer()
            }
            
            HStack(spacing: 24) {
                VStack {
                    HStack(spacing: 4) {
                        Image("magic-book")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("Mastered Spells")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    
                    Text("\(masterSpellsCount)/\(totalSpells)")
                        .font(.headline)
                        .foregroundColor(Color("accent-color"))
                }
                
                VStack {
                    HStack(spacing: 4) {
                        Image("schools")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("Mastered Schools")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    
                    Text("\(grandSorcererSchoolsCount)/\(totalSchools)")
                        .font(.headline)
                        .foregroundColor(Color("accent-color"))
                }
            }
        }
        .padding()
        .withCardStyle()
    }
}


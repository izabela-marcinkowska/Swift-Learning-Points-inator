//
//  SchooGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-22.
//

import SwiftUI
import SwiftData

struct SchoolGridItem: View {
    let school: SchoolOfMagic
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    private var user: User? {
        users.first
    }
    
    private var schoolProgress: SchoolProgress? {
        user?.schoolProgress.first { $0.school == school}
    }
    
    /// Determines the next achievement level for this school if available.
    /// Returns nil if:
    /// - No current level exists
    /// - User is already at the maximum level (Grand Sorcerer)
    ///
    /// For example, if current level is 'apprentice' (0), returns 'mage' (1).
    /// If current level is 'grandSorcerer' (3), returns nil.
    private var nextLevel: SchoolOfMagic.AchievementLevel? {
        guard let currentLevel = schoolProgress?.currentLevel,
              currentLevel.rawValue < SchoolOfMagic.AchievementLevel.allCases.count - 1 else {
            return nil
        }
        return SchoolOfMagic.AchievementLevel(rawValue: currentLevel.rawValue + 1)
    }
    
    /// Creates a string showing progress towards next level threshold.
    /// Format: "currentMana/nextLevelThreshold"
    ///
    /// Examples:
    /// - "150/300" (150 mana earned, need 300 for next level)
    /// - "2600/2600" (at max level, showing current mana)
    ///
    /// If no progress exists, defaults to "0/0"
    private var manaProgress: String {
        let currentMana = schoolProgress?.totalMana ?? 0
        let nextThreshold = nextLevel?.manaThreshold ?? currentMana
        return "\(currentMana)/\(nextThreshold)"
    }
    
    var body: some View {
        HStack() {
            Image(school.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
            
            VStack(spacing: 8) {
                
                Text(school.rawValue)
                    .font(.title2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                
                Text(school.titleForLevel(schoolProgress?.currentLevel ?? .apprentice))
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                
                Text(manaProgress)
                    .font(.caption)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 8)
            
            
        }
        .padding()
        .background(Color("card-background"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    SchoolGridItem(school: .everydayEndeavors)
}

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
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: school.icon)
                .font(.system(size: 32))
                .foregroundColor(.blue)
                .padding(.top, 8)
            
            VStack(spacing: 8) {
                
            Text(school.rawValue)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            
            Text(school.titleForLevel(schoolProgress?.currentLevel ?? .apprentice))
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 8)
            
            Text(manaProgress)
                .font(.caption)
                .padding(.bottom, 8)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    SchoolGridItem(school: .dataSorcery)
}

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
    
    // Calculate how much more mana is needed for next level
    private var manaNeededForNextLevel: Int {
        guard let nextLevel = nextLevel,
              let currentMana = schoolProgress?.totalMana else {
            return 0
        }
        
        return max(0, nextLevel.manaThreshold - currentMana)
    }
    
    // Text to display about level progress
    private var levelUpText: String {
        guard let nextLevel = nextLevel else {
            return "Maximum level achieved"
        }
        
        return "For \(nextLevel.title), need \(manaNeededForNextLevel) more mana"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack(spacing: 6) {
                Image(schoolProgress?.currentLevel.imageName ?? "apprentice")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                
                Text(schoolProgress?.currentLevel.title ?? "apprentice")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
            }
            .frame(height: 40)
            
            Image(school.imageName)
                .resizable()
                .scaledToFit()
                .opacity(0.80)
                .frame(width: 80, height: 80)
            
            Spacer(minLength: 4)
            Text("of \(school.rawValue)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 4)
            
            Text(levelUpText)
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 270)
        .withCardStyle()
    }
}

#Preview {
    SchoolGridItem(school: .everydayEndeavors)
}

//
//  LevelIndicator.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-05.
//

import SwiftUI

struct LevelIndicator: View {
    let level: SchoolOfMagic.AchievementLevel
    let isAchieved: Bool
    let progressText: String?
    
    var body: some View {
        HStack (alignment: .center, spacing: 8) {
            Image(level.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .grayscale(isAchieved ? 0.0 : 0.9)
                .opacity(isAchieved ? 1 : 0.7)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(level.title)
                    .font(.subheadline)
                    .foregroundColor(isAchieved ? Color("accent-color") : .gray.opacity(0.5))
                
                if let progress = progressText {
                    Text(progress)
                        .font(.caption2)
                        .foregroundColor(Color("accent-color"))
                        .padding(.leading, 4)
                }
            }
            Spacer()
        }
    }
}

struct LevelProgressionBar: View {
    let currentLevel: SchoolOfMagic.AchievementLevel
    let manaProgress: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Current level:")
                .font(.headline)
            ForEach(SchoolOfMagic.AchievementLevel.allCases, id: \.self) { level in
                
                let progressToShow = level == currentLevel ? manaProgress : nil
                LevelIndicator(
                    level: level,
                    isAchieved: level.rawValue <= currentLevel.rawValue,
                    progressText: progressToShow
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(Color("card-background"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

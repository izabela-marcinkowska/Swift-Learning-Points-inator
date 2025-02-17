//
//  RecentAchievementView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-17.
//

import SwiftUI

struct RecentAchievementView: View {
    let achievement: User.RecentAchievement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Achievement")
                .font(.headline)
            
            HStack {
                switch achievement.type {
                case .school(let school, _):
                    Image(systemName: school.icon)
                case .spell(let spell, _):
                    Image(systemName: spell.icon)
                }
                
                Text(achievement.description)
                    .font(.subheadline)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

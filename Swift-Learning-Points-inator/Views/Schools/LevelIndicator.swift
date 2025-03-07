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
    let statusText: String?
    let isCurrent: Bool
    
    private func getStatusColor() -> Color {
        if isAchieved && !isCurrent {
            return .green  // Fully achieved levels
        } else if isCurrent {
            return Color("progress-color")  // Current level in progress
        } else {
            return .secondary  // Future levels not yet achieved
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                Image(level.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .grayscale(isAchieved ? 0.0 : 0.9)
                    .opacity(isAchieved ? 1 : 0.7)
                
                VStack(alignment: .leading, spacing: 2) {
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
                    
                    if let status = statusText {
                        Text(status)
                            .font(.caption)
                            .foregroundColor(getStatusColor())
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
        }
    }
}


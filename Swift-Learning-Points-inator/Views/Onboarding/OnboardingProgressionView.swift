//
//  OnboardingProgressionView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-07.
//

import SwiftUI

struct OnboardingProgressionView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("schools")
                .resizable()
                .scaledToFit()
                .frame(height: 140)
            
            Text("Learning Progression")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 15) {
                FeatureRow(
                    icon: "graduationcap.fill",
                    text: "Progress through different Schools of Magic"
                )
                
                FeatureRow(
                    icon: "chart.line.uptrend.xyaxis",
                    text: "Gain experience and level up from Apprentice to Grand Sorcerer"
                )
                
                FeatureRow(
                    icon: "calendar",
                    text: "Maintain daily streaks to build consistent learning habits"
                )
                
                FeatureRow(
                    icon: "trophy.fill",
                    text: "Track your achievements and celebrate your learning journey"
                )
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

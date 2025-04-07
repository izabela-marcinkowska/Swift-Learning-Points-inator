//
//  OnboardingSpellsView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-07.
//

import SwiftUI

struct OnboardingSpellsView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("magic-book") 
                .resizable()
                .scaledToFit()
                .frame(height: 140)
            
            Text("Magical Spells & Mana")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 15) {
                FeatureRow(
                    icon: "diamond.fill",
                    text: "Earn Mana Essence by completing tasks"
                )
                
                FeatureRow(
                    icon: "wand.and.stars",
                    text: "Invest mana in powerful spells to enhance your learning"
                )
                
                FeatureRow(
                    icon: "arrow.up.forward",
                    text: "Level up spells to receive even greater bonuses"
                )
                
                FeatureRow(
                    icon: "sparkles",
                    text: "Higher level spells provide mana bonuses to specific schools"
                )
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

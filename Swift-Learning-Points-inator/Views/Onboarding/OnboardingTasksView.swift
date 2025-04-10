//
//  OnboardingTasksView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-07.
//

import SwiftUI

struct OnboardingTasksView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("tasks-icon")
                .resizable()
                .scaledToFit()
                .frame(height: 140)
            
            Text("Magical Tasks")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 15) {
                FeatureRow(
                    icon: "checkmark.circle.fill",
                    text: "Create tasks for different schools of magic"
                )
                
                FeatureRow(
                    icon: "star.fill",
                    text: "Complete tasks to earn mana essence"
                )
                
                FeatureRow(
                    icon: "repeat",
                    text: "Daily tasks reset each day for consistent practice"
                )
            }
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack (alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(Color("accent-color"))
                .font(.system(size: 22))
                .frame(width: 24)
            
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

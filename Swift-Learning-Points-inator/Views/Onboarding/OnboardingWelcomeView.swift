//
//  OnboardingWelcomeView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-07.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("magic-book")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            Text("Welcome to Digital Sorcery!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Begin your journey into magical coding with this enchanted learning tracker.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding()
    }
}



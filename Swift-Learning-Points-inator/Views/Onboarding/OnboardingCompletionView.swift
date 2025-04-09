//
//  OnboardingCompletionView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-09.
//

import SwiftUI

struct OnboardingCompletionView: View {
    let userName: String
    
    var body: some View {
        VStack (spacing: 30) {
            Image("witchexample")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            Text("Welcome, \(userName.isEmpty ? "Apprentice" : userName)!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Your magical coding journey begins now. Complete tasks, learn new spells, and become a Grand Sorcerer of coding!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Image("diamond")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

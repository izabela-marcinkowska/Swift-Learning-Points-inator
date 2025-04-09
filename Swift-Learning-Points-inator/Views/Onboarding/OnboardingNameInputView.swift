//
//  OnboardingNameInputView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-09.
//

import SwiftUI

struct OnboardingNameInputView: View {
    @Binding var userName: String
    @FocusState private var isNameFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(height: 140)
            
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Tell us what to call you, future magic coder!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            TextField("Enter your name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
                .focused($isNameFieldFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isNameFieldFocused = true
                    }
                }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}


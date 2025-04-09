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
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                            TextField("Enter your name", text: $userName)
                                .padding()
                                .background(Color("card-background"))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                                )
                                .focused($isNameFieldFocused)
                        }
                        .padding(.horizontal, 40)
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


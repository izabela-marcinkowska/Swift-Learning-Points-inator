//
//  OnboardingNameInputView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-09.
//

import SwiftUI

struct OnboardingNameInputView: View {
    @Binding var userName: String
    @Binding var selectedGender: UserGender
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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Choose your avatar type:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 15) {
                        ForEach(UserGender.allCases, id: \.self) { gender in
                            GenderOptionView(gender: gender, isSelected: selectedGender == gender, action: { selectedGender = gender })
                        }
                    }
                }
                
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

struct GenderOptionView: View {
    let gender: UserGender
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(gender.avatarName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color("accent-color") : Color.clear, lineWidth: 3)
                    )
                
                Text(gender.rawValue)
                    .font(.caption)
                    .foregroundStyle(isSelected ? Color("accent-color") : .primary)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("card-background").opacity(0.3))
                    .opacity(isSelected ? 1 : 0.7)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

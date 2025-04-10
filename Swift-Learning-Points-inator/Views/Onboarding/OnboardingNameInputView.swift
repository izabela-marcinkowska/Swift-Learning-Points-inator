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
            Text("Tell us about yourself!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            // Name section
            VStack(spacing: 12) {
                Text("What's your name?")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TextField("Enter your name", text: $userName)
                    .padding()
                    .background(Color("card-background"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                    )
                    .focused($isNameFieldFocused)
                    .padding(.horizontal, 20)
            }
            
            // Visual separator
            Divider()
                .padding(.vertical, 10)
                .padding(.horizontal, 40)
            
            // Gender selection section
            VStack(spacing: 12) {
                Text("Choose your avatar style")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Select which type of character represents you best!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 15) {
                    ForEach(UserGender.allCases, id: \.self) { gender in
                        GenderOptionView(
                            gender: gender,
                            isSelected: selectedGender == gender,
                            action: { selectedGender = gender }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isNameFieldFocused = true
            }
        }
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
                    .frame(height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color("accent-color") : Color.clear, lineWidth: 2)
                    )
                
                Text(gender.rawValue)
                    .font(.caption)
                    .foregroundStyle(isSelected ? Color("accent-color") : .primary)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)

        }
        .buttonStyle(PlainButtonStyle())
    }
}

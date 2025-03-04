//
//  ManaButtonStyle.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-03.
//

import SwiftUI

struct InvestManaButton: View {
    let text: String
    let action: () -> Void
    var isEnabled: Bool = true
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(ManaButtonStyle(isEnabled: isEnabled))
        .disabled(!isEnabled)
        .padding(.bottom, 8)
    }
}

struct ManaButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: isEnabled
                            ? [Color("button-color").opacity(0.7), Color("button-color")]
                            : [Color.gray.opacity(0.4), Color.gray.opacity(0.6)]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(isEnabled ? .white : .white.opacity(0.7))
            .cornerRadius(12)
            .shadow(
                color: isEnabled
                    ? Color("button-color").opacity(0.4)
                    : Color.gray.opacity(0.2),
                radius: 4,
                x: 0,
                y: 2
            )
            .scaleEffect(configuration.isPressed && isEnabled ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .opacity(isEnabled ? 1.0 : 0.7)
    }
}

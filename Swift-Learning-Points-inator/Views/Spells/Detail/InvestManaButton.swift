//
//  ManaButtonStyle.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-03.
//

import SwiftUI

struct InvestManaButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Invest Mana")
                .font(.headline)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(ManaButtonStyle())
        .padding(.bottom, 8)
    }
}

struct ManaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("button-color").opacity(0.7), Color("button-color")]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: Color("button-color").opacity(0.4), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

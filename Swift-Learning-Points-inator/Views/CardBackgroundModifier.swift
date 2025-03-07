//
//  CardBackgroundModifier.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-07.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    let cornerRadius: CGFloat
    let useGradient: Bool
    
    init(cornerRadius: CGFloat = 10, useGradient: Bool = true) {
        self.cornerRadius = cornerRadius
        self.useGradient = useGradient
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if useGradient {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("card-background"),
                                Color("card-background").opacity(0.9),
                                Color.black.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    } else {
                        Color("card-background")
                    }
                }
            )
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.purple.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func withCardStyle(cornerRadius: CGFloat = 10, useGradient: Bool = true) -> some View {
        self.modifier(CardBackgroundModifier(cornerRadius: cornerRadius, useGradient: useGradient))
    }
}

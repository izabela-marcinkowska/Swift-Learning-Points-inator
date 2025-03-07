//
//  GradientBackgroundModifier.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-07.
//

import SwiftUI

struct GradientBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("background-color"),
                        Color("background-color").opacity(0.9),
                        Color.black
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

extension View {
    func withGradientBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}

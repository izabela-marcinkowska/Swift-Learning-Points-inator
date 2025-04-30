//
//  DashboardPlaceholders.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-10.
//

import SwiftUI

struct EmptyAchievementView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Achievement Awaits")
                .font(.headline)
            
            HStack {
              Image("magic-book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                
                Text("Complete tasks to earn your first magical achievement")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct EmptyTasksView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Begin Your Journey")
                .font(.headline)
            
            NavigationLink(destination: TasksView()) {
                HStack {
                    Image("tasks-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    
                    Text("Start by completing your first magical task")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .withWaveAnimation(accent: Color("accent-color").opacity(0.8))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct WaveAnimationModifier: ViewModifier {
    @State private var isAnimating = false
    let accent: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        Path { path in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            path.move(to: CGPoint(x: width, y: 0))
                            path.addQuadCurve(
                                to: CGPoint(x: 0, y: height),
                                control: CGPoint(x: width * 0.5, y: height * 0.5)
                            )
                            path.addLine(to: CGPoint(x: width, y: height))
                            path.closeSubpath()
                        }
                        .fill(accent.opacity(0.1))
                        .mask(
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.clear, Color.white.opacity(0.7), .clear]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    )
                                )
                        )
                        .offset(x: isAnimating ? -geometry.size.width : geometry.size.width)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

extension View {
    func withWaveAnimation(accent: Color = Color("accent-color")) -> some View {
        self.modifier(WaveAnimationModifier(accent: accent))
    }
}

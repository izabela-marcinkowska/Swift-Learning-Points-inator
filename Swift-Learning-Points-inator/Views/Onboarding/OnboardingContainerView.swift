//
//  OnboardingContainerView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-06.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var onboardingManager = OnboardingManager()
    @State private var currentPage = 0
    @State private var userName: String = ""
    
    private let  pageCount = 6
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("background-color"),
                    Color("background-color").opacity(0.9),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Page content
                ZStack {
                    if currentPage == 0 {
                        OnboardingWelcomeView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    } else if currentPage == 1 {
                        OnboardingTasksView()
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            ))
                    }
                        .animation(.easeInOut(duration: 0.3), value: currentPage)
                }
                
                Spacer()
                HStack (spacing: 16) {
                    if currentPage > 0 {
                        Button {
                            withAnimation {
                                currentPage -= 1
                            }
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                        .buttonStyle(SecondaryAlertButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                    
                    
                    MagicalButton(
                        text: currentPage < pageCount - 1 ? "Next" : "Get Started",
                        action: {
                            withAnimation {
                                if currentPage < pageCount - 1 {
                                    currentPage += 1
                                } else {
                                    // Complete onboarding
                                    onboardingManager.completeOnboardning()
                                }
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    OnboardingContainerView()
}

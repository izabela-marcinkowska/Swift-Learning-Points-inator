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
                
                HStack {
                    Button(action: {
                        withAnimation {
                            currentPage -= 1
                        }
                    }) {
                        Text("Back")
                            .padding()
                            .opacity(currentPage > 0 ? 1 : 0)
                    }
                    .disabled(currentPage == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            if currentPage < pageCount - 1 {
                                currentPage += 1
                            } else {
                                onboardingManager.completeOmboardning()
                            }
                        }
                    }) {
                        Text(currentPage < pageCount - 1 ? "Next" : "Get started")
                            .padding()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    OnboardingContainerView()
}

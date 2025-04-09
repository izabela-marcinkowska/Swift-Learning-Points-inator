//
//  OnboardingContainerView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-06.
//

import SwiftUI
import SwiftData

struct OnboardingContainerView: View {
    @StateObject private var onboardingManager = OnboardingManager()
    @Environment(\.modelContext) private var modelContext
    @State private var currentPage = 0
    @State private var userName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    private let  pageCount = 6
    
    private func saveUserName() {
        guard !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let descriptor = FetchDescriptor<User>()
        do {
            let users = try modelContext.fetch(descriptor)
            if let user = users.first {
                user.name = userName
                try modelContext.save()
            }
        } catch {
            print("Error saving user name: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
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
                    Spacer()
                    
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
                        } else if currentPage == 2 {
                            OnboardingSpellsView()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)
                                ))
                        } else if currentPage == 3 {
                            OnboardingProgressionView()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)
                                ))
                        } else if currentPage == 4 {
                            OnboardingNameInputView(userName: $userName)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)
                                ))
                        } else if currentPage == 5 {
                            OnboardingCompletionView(userName: userName)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)
                                ))
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
                    
                    Spacer()
                    
                    HStack (spacing: 8) {
                        ForEach(0..<6) { index in
                            Circle()
                                .fill(currentPage == index ? Color("accent-color") : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    MagicalButton(
                        text: currentPage < pageCount - 1 ? "Next" : "Get Started",
                        action: {
                            withAnimation {
                                if currentPage < pageCount - 1 {
                                    if currentPage == 4 && !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                        // Save user name to your User model
                                        saveUserName()
                                    }
                                    currentPage += 1
                                    } else {
                                        // Complete onboarding
                                        onboardingManager.completeOnboardning()
                                        dismiss()
                                    }
                                }
                            }
                        )
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentPage > 0 {
                        Button {
                            withAnimation {
                                currentPage -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(Color("accent-color"))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(Color("accent-color"))
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

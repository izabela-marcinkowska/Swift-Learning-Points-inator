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
    @State private var movingForward = true
    
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
    
    var currentOnboardingView: some View {
        switch currentPage {
        case 0:
            return AnyView(OnboardingWelcomeView().zIndex(1))
        case 1:
            return AnyView(OnboardingTasksView().zIndex(1))
        case 2:
            return AnyView(OnboardingSpellsView().zIndex(1))
        case 3:
            return AnyView(OnboardingProgressionView().zIndex(1))
        case 4:
            return AnyView(OnboardingNameInputView(userName: $userName).zIndex(1))
        case 5:
            return AnyView(OnboardingCompletionView(userName: userName).zIndex(1))
        default:
            return AnyView(EmptyView())
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
                    
                    
                    currentOnboardingView
                        .id(currentPage)
                        .transition(.asymmetric(
                            insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                            removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                        ))
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
                        isEnabled: currentPage != 4 || !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                        action: {
                            movingForward = true
                            withAnimation {
                                if currentPage < pageCount - 1 {
                                            saveUserName() // Perform the save _before_ the animated transition.
                                            withAnimation {
                                                currentPage += 1
                                            }
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
                            movingForward = false    // Update the flag immediately
                            withAnimation {
                                currentPage -= 1      // Then animate the page change
                            }
                            print("Moving forward? \(movingForward)")
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

//
//  UserView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-09.
//

import SwiftUI
import SwiftData
import SafariServices

struct UserView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    @Environment(\.modelContext) private var modelContext
    @State private var showAlert: Bool = false
    @State private var newName = ""
    @State private var showOnboarding: Bool = false
    
    private func submit () {
        if let user = user {
            user.name = newName
            try? modelContext.save()
        }
        newName = ""
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    SettingsSection(title: "User Information") {
                        VStack(spacing: 12) {
                            SettingsRowItem(
                                icon: "user-icon",
                                title: "Change Name",
                                action: {
                                    showAlert.toggle()
                                },
                                subtitle: user?.name ?? "User"
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    SettingsSection(title: "App Settings") {
                        VStack(spacing: 12) {
                            SettingsRowItem(
                                icon: "notifications-icon",
                                title: "Notifications",
                                action: {
                                    // Handle notifications setting
                                }
                            )
                            
                            SettingsRowItem(
                                icon: "magic-book",
                                title: "Start Onboarding",
                                action: {
                                    let manager = OnboardingManager()
                                    manager.resetOmboarding()
                                    showOnboarding.toggle()
                                }
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    SettingsSection(title: "Connect") {
                        VStack(spacing: 12) {
                            SettingsRowItem(
                                icon: "threads-icon",
                                title: "Follow on Threads",
                                action: {
                                    if let url = URL(string: "https://www.threads.net/@bugs_and_lemons") {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                subtitle: "@bugs_and_lemons"
                            )
                            
                            SettingsRowItem(
                                icon: "instagram-icon",
                                title: "Follow on Instagram",
                                action: {
                                    if let url = URL(string: "https://www.instagram.com/bugs_and_lemons/") {
                                        UIApplication.shared.open(url)
                                    }
                                },
                                subtitle: "@bugs_and_lemons"
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: ButtonsShow()) {
                        Text("Visa Alert Knappar")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    // Add more sections as needed
                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity)
            .withGradientBackground()
            .navigationTitle("Profile")
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingContainerView()
            }
            .alert("Enter your name", isPresented: $showAlert) {
                TextField("Name", text: $newName)
                Button("Cancel", role: .cancel) {}
                Button("OK", action: submit)
            } message: {
                Text("Please enter your name")
            }
        }
        .tint(Color("accent-color"))
    }
}

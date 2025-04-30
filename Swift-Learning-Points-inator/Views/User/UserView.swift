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
    @EnvironmentObject var toastManager: ToastManager
    @State private var notificationsEnabled = false
    
    /// Submits the changes made in the user profile, specifically updating the user's name.
    private func submit () {
        if let user = user {
            user.name = newName
            if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "updating user name") {
                newName = ""
            }
        } else {
            toastManager.showError(AppError.generalError("User profile not found"))
        }
    }
    
    /// Refreshes the `notificationsEnabled` state by checking the current notification permission status and the user's preference.
    private func refreshNotificationStatus() {
        NotificationManager.shared.checkPermissionStatus { status in
            let userPreference = NotificationManager.shared.getUserNotificationPreference()
            notificationsEnabled = (status == .authorized && userPreference)
        }
    }
    
    /// Handles the toggling of the notification preference. It updates the user's preference and requests permission if enabling notifications. If disabling, it removes all pending notifications.
    ///
    /// - Parameter isEnabled: A boolean value indicating whether notifications are being enabled (`true`) or disabled (`false`).
    private func handleNotificationToggle(isEnabled: Bool) {
        NotificationManager.shared.setUserNotificationPreference(enabled: isEnabled)
        
        if isEnabled {
            NotificationManager.shared.requestPermission { granted in
                if !granted {
                    notificationsEnabled = false
                    NotificationManager.shared.setUserNotificationPreference(enabled: false)
                    
                    toastManager.showError(AppError.generalError("Please enable notifications in Settings to receive reminders"))
                }
            }
        } else {
            NotificationManager.shared.removeAllPendingNotifications()
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if let user = user {
                        UserCardView(user: user)
                            .padding(.horizontal)
                    }
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
                            SettingsToggleItem(
                                icon: "notifications-icon",
                                title: "Enable Notifications",
                                subtitle: "Receive streak reminders and achievement alerts",
                                isOn: $notificationsEnabled,
                                action: handleNotificationToggle
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
                    
                    SettingsSection(title: "Debug") {
                        VStack(spacing: 12) {
                            SettingsRowItem(
                                icon: "debug-icon",
                                title: "Test Error Toast",
                                action: {
                                    toastManager.showError(AppError.generalError("This is test error msg"))
                                }
                            )
                            
                            SettingsRowItem(
                                icon: "debug-icon",
                                title: "Test Model Error",
                                action: {
                                    let _ = toastManager.performWithErrorHandling(context: "testing errors") {
                                        throw AppError.dataModification("Simulated data error for testing")
                                    }
                                }
                            )
                            
                            
                            SettingsRowItem(
                                icon: "debug-icon",
                                title: "Notification Permission",
                                action: {
                                    NotificationManager.shared.requestPermission { granted in
                                        print("Notification permission granted: \(granted)")
                                    }
                                })
                            
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
        .onAppear {
            refreshNotificationStatus()
        }
    }
}

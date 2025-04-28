//
//  Swift_Learning_Points_inatorApp.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

@main
struct Swift_Learning_Points_inatorApp: App {
    let container: ModelContainer
    @StateObject private var taskNotificationManager = TaskNotificationManager()
    @StateObject private var toastManager = ToastManager()
    @StateObject private var onboardingManager = OnboardingManager()
    
    init() {
        let lightAppearance = UITabBarAppearance()
        lightAppearance.configureWithDefaultBackground()
        
#if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try! ModelContainer(for: User.self, configurations: config)
            return
        }
#endif
        do {
            container = try ModelContainer(for: User.self, Task.self, Spell.self, SchoolProgress.self, Affirmation.self, AffirmationManager.self)
            
            let modelContext = container.mainContext
            
            let userDescriptor = FetchDescriptor<User>()
            configureTabBarAppearance()
            
            
         
            
            
            // MARK: - Affirmation
            
            let affirmationDescriptor = FetchDescriptor<Affirmation>()
            let existingAffirmationCount = try modelContext.fetchCount(affirmationDescriptor)
            
            if existingAffirmationCount == 0 {
                SampleAffirmations.allAffiliations.forEach { affirmation in
                    modelContext.insert(affirmation)
                }
                
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving affirmations: \(error)")
                }
            }
            
            let affirmationManagerDescriptor = FetchDescriptor<AffirmationManager>()
            let existingManagerCount = try modelContext.fetchCount(affirmationManagerDescriptor)
            
            if existingManagerCount == 0 {
                let manager = AffirmationManager()
                modelContext.insert(manager)
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving affirmation manager: \(error)")
                }
            }
            
            // MARK: - Task
            let descriptor = FetchDescriptor<Task>()
            let existingTaskCount = try modelContext.fetchCount(descriptor)
            
            if existingTaskCount == 0 {
                SampleTasks.allTasks.forEach { task in
                    modelContext.insert(task)
                }
                
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving context: \(error)")
                }
            }
            
            // MARK: - Spell
            
            let spellDescriptor = FetchDescriptor<Spell>()
            let existingSpellCount = try modelContext.fetchCount(spellDescriptor)
            
            if existingSpellCount == 0 {
                SampleSpells.allSpells.forEach { spell in
                    modelContext.insert(spell)
                }
                
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving spells: \(error)")
                }
            }
            
            //MARK: - User
            
            let existingUserCount = try modelContext.fetchCount(userDescriptor)
            
            if existingUserCount == 0 {
                let newUser = User(name: "Bella", mana: 0, streak: 0)
                modelContext.insert(newUser)
                do {
                    try modelContext.save()
                } catch {
                    print("Error saving context: \(error)")
                }
            }
            
            if existingUserCount > 0 {
                let users = try modelContext.fetch(userDescriptor)
                if let user = users.first {
                    let status = user.checkStreakStatus()
                    
                    if status == .broken {
                        user.streak = 0
                        user.lastStreakDate = nil
                        do {
                            try modelContext.save()
                        } catch {
                            print("Error saving context: \(error)")
                        }
                    }
                }
            }
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        // Always use dark appearance
        appearance.backgroundColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Selected state is blue for contrast
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "button-color")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "progress-color") ?? .blue]
        
        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskNotificationManager)
                .environmentObject(toastManager)
                .environmentObject(onboardingManager)
                .onAppear {
                    taskNotificationManager.setToastManager(manager: toastManager)
                    
                    TaskResetManager.shared.checkAndResetTasks(
                        modelContext: container.mainContext,
                        toastManager: toastManager
                    )
                }
        }
        .modelContainer(container)
    }
}

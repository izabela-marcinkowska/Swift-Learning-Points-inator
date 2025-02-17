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
            if let user = try? modelContext.fetch(userDescriptor).first {
                configureTabBarAppearance(for: user.themePreference)
            } else {
                configureTabBarAppearance(for: .system)
            }
            
            
            TaskResetManager.shared.checkAndResetTasks(modelContext: modelContext)
            
            
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
    
    private func configureTabBarAppearance(for theme: ThemePreference) {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        // Set colors based on theme
        switch theme {
        case .dark:
            appearance.backgroundColor = .black
            appearance.stackedLayoutAppearance.normal.iconColor = .white
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        case .light:
            appearance.backgroundColor = .systemBackground
            // Using a softer color instead of pure black
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        case .system:
            appearance.backgroundColor = .systemBackground
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        }
        
        // Selected state is always blue for contrast
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        let tabBar = UITabBar.appearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}

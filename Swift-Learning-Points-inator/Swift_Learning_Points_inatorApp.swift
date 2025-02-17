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
        let lightAppearance = UITabBarAppearance()
        lightAppearance.configureWithDefaultBackground()
        lightAppearance.backgroundColor = .white
        lightAppearance.stackedLayoutAppearance.normal.iconColor = .black
        lightAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        lightAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        lightAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        let darkAppearance = UITabBarAppearance()
        darkAppearance.configureWithDefaultBackground()
        darkAppearance.backgroundColor = .black
        darkAppearance.shadowColor = .clear
        darkAppearance.shadowImage = UIImage()
        darkAppearance.stackedLayoutAppearance.normal.iconColor = .white
        darkAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        darkAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        darkAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        let tabBar = UITabBar.appearance()
        
        switch theme {
        case .dark:
            tabBar.standardAppearance = darkAppearance
            tabBar.scrollEdgeAppearance = darkAppearance
        case .light:
            tabBar.standardAppearance = lightAppearance
            tabBar.scrollEdgeAppearance = lightAppearance
        case .system:
            // For system theme, we'll check the current interface style
            if UITraitCollection.current.userInterfaceStyle == .dark {
                tabBar.standardAppearance = darkAppearance
                tabBar.scrollEdgeAppearance = darkAppearance
            } else {
                tabBar.standardAppearance = lightAppearance
                tabBar.scrollEdgeAppearance = lightAppearance
            }
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}

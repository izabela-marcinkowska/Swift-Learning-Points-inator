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
        do {
            container = try ModelContainer(for: User.self, Task.self, Spell.self, SchoolProgress.self, Affirmation.self, AffirmationManager.self)

            let modelContext = container.mainContext
            // MARK: - Affirmation
            
            let affirmationDescriptor = FetchDescriptor<Affirmation>()
            let existingAffirmationCount = try modelContext.fetchCount(affirmationDescriptor)

            if existingAffirmationCount == 0 {
                [
                    // Learning Growth affirmations
                    Affirmation(
                        text: "Every line of code I write makes me a better programmer",
                        category: .learning
                    ),
                    Affirmation(
                        text: "I embrace debugging as an opportunity to learn and grow",
                        category: .learning
                    ),
                    Affirmation(
                        text: "My coding skills improve with each project I undertake",
                        category: .learning
                    ),
                    
                    // Persistence affirmations
                    Affirmation(
                        text: "Errors and bugs are stepping stones to mastery",
                        category: .persistence
                    ),
                    Affirmation(
                        text: "I persist through challenges, knowing they make me stronger",
                        category: .persistence
                    ),
                    Affirmation(
                        text: "Every obstacle in my code is an opportunity to learn",
                        category: .persistence
                    ),
                    
                    // Confidence affirmations
                    Affirmation(
                        text: "I am capable of solving complex programming problems",
                        category: .confidence
                    ),
                    Affirmation(
                        text: "My unique perspective brings value to my coding projects",
                        category: .confidence
                    ),
                    Affirmation(
                        text: "I trust in my ability to learn and master new technologies",
                        category: .confidence
                    ),
                    
                    // Creativity affirmations
                    Affirmation(
                        text: "I approach coding challenges with creativity and innovation",
                        category: .creativity
                    ),
                    Affirmation(
                        text: "My imagination helps me find elegant solutions",
                        category: .creativity
                    ),
                    Affirmation(
                        text: "I see each project as a canvas for creative expression",
                        category: .creativity
                    ),
                    
                    // Well-being affirmations
                    Affirmation(
                        text: "I maintain a healthy balance between coding and rest",
                        category: .wellbeing
                    ),
                    Affirmation(
                        text: "Taking breaks makes me a more effective programmer",
                        category: .wellbeing
                    ),
                    Affirmation(
                        text: "My well-being enhances my coding productivity",
                        category: .wellbeing
                    )
                ].forEach { affirmation in
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
            
            let userDescriptor = FetchDescriptor<User>()
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
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(container)
    }
}

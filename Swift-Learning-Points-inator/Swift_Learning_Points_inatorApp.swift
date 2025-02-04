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
            container = try ModelContainer(for: User.self, Task.self, Spell.self, SchoolProgress.self, Affirmation.self)

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
            
            // MARK: - Task
            let descriptor = FetchDescriptor<Task>()
            let existingTaskCount = try modelContext.fetchCount(descriptor)
            
            if existingTaskCount == 0 {
                [
                    Task(name: "Design a magical user interface", mana: 50, school: .interfaceEnchantments),
                    Task(name: "Debug a complex spell", mana: 75, school: .dataSorcery),
                    Task(name: "Study ancient scrolls (documentation)", mana: 30, school: .arcaneStudies),
                    Task(name: "Practice temporal magic patterns", mana: 40, school: .temporalMagic),
                    Task(name: "Craft a new transformation spell", mana: 100, school: .transformationSpells)
                ].forEach { task in
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
                [
                    // Focus Enhancement Spells
                    Spell(
                        name: "Mind Sharpening Charm",
                        spellDescription: "A fundamental spell that enhances your ability to concentrate during coding sessions. As you upgrade it, your focus periods become more effective.",
                        category: .focus,
                        icon: "brain.fill",
                        investedMana: 150  
                    ),
                    Spell(
                        name: "Distraction Ward",
                        spellDescription: "Creates a magical barrier against distractions while you're deep in code. Higher levels strengthen this protective enchantment.",
                        category: .focus,
                        icon: "shield.fill",
                        investedMana: 560
                    ),
                    Spell(
                        name: "Time Dilation Spell",
                        spellDescription: "Makes your study time feel more productive by helping you enter a state of flow. Upgrading deepens this temporal enhancement.",
                        category: .focus,
                        icon: "hourglass.circle.fill"
                    ),
                    
                    // Restoration Spells
                    Spell(
                        name: "Energy Renewal Charm",
                        spellDescription: "Enhances the effectiveness of your coding breaks. Higher levels provide more rejuvenation during rest periods.",
                        category: .restoration,
                        icon: "bolt.circle.fill"
                    ),
                    Spell(
                        name: "Rest Ritual",
                        spellDescription: "Establishes magical patterns for regular breaks. Upgrading helps create better rest habits.",
                        category: .restoration,
                        icon: "moon.stars.fill"
                    ),
                    Spell(
                        name: "Refreshment Enchantment",
                        spellDescription: "Quick energy restoration between coding sessions. More powerful versions provide deeper refreshment.",
                        category: .restoration,
                        icon: "leaf.fill"
                    ),
                    
                    // Balance Spells
                    Spell(
                        name: "Harmony Weaver",
                        spellDescription: "Helps maintain balance between coding practice and rest. Higher levels create stronger harmony.",
                        category: .balance,
                        icon: "yin.yang"
                    ),
                    Spell(
                        name: "Boundary Guardian",
                        spellDescription: "Assists in setting healthy limits on coding sessions. Upgrading strengthens your time boundaries.",
                        category: .balance,
                        icon: "clock.badge.checkmark.fill"
                    ),
                    Spell(
                        name: "Flow Stabilizer",
                        spellDescription: "Maintains steady progress in your learning journey. Enhanced versions provide more stable progress patterns.",
                        category: .balance,
                        icon: "waveform.path"
                    ),
                    
                    // Clarity Spells
                    Spell(
                        name: "Concept Crystallization",
                        spellDescription: "Makes complex coding concepts easier to grasp. Higher levels enhance your understanding.",
                        category: .clarity,
                        icon: "sparkles.square.filled.on.square"
                    ),
                    Spell(
                        name: "Error Insight Charm",
                        spellDescription: "Improves your ability to understand and fix bugs. Upgrading deepens your debugging intuition.",
                        category: .clarity,
                        icon: "magnifyingglass.circle.fill"
                    ),
                    Spell(
                        name: "Pattern Recognition Spell",
                        spellDescription: "Helps identify common coding patterns. More powerful versions enhance pattern recognition.",
                        category: .clarity,
                        icon: "square.grid.3x3.fill"
                    ),
                    
                    // Perseverance Spells
                    Spell(
                        name: "Debug Fortitude",
                        spellDescription: "Strengthens your resilience during debugging sessions. Higher levels provide greater endurance.",
                        category: .perseverance,
                        icon: "hammer.circle.fill"
                    ),
                    Spell(
                        name: "Challenge Crusher",
                        spellDescription: "Boosts confidence when facing difficult coding tasks. Upgrading enhances your problem-solving spirit.",
                        category: .perseverance,
                        icon: "mountain.2.fill"
                    ),
                    Spell(
                        name: "Progress Momentum",
                        spellDescription: "Helps maintain motivation in your coding journey. More powerful versions create stronger momentum.",
                        category: .perseverance,
                        icon: "arrow.up.forward.circle.fill"
                    ),
                    
                    // Seasonal Spell Example
                    Spell(
                        name: "Winter's Focus",
                        spellDescription: "A seasonal enchantment that brings the clarity of winter frost to your coding practice. Available during winter months.",
                        category: .seasonal,
                        icon: "snowflake"
                    )
                ].forEach { spell in
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

//
//  SampleTasks.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation

enum SampleTasks {
    // Interface Enchantments Tasks
    static let interfaceEnchantmentTasks: [Task] = [
        // Easy tasks
        Task(name: "Practice basic animations",
             mana: 30,
             school: .interfaceEnchantments),
        Task(name: "Style a button with modifiers",
             mana: 25,
             school: .interfaceEnchantments),
        
        // Medium tasks
        Task(name: "Create a custom tab view",
             mana: 60,
             school: .interfaceEnchantments),
        Task(name: "Implement gesture recognizers",
             mana: 50,
             school: .interfaceEnchantments),
        
        // Hard tasks
        Task(name: "Build a complex navigation system",
             mana: 100,
             school: .interfaceEnchantments),
        Task(name: "Create a custom chart visualization",
             mana: 90,
             school: .interfaceEnchantments)
    ]
    
    // Data Sorcery Tasks
    static let dataSorceryTasks: [Task] = [
        // Easy tasks
        Task(name: "Create a basic SwiftData model",
             mana: 30,
             school: .dataSorcery),
        Task(name: "Implement simple CRUD operations",
             mana: 35,
             school: .dataSorcery),
        
        // Medium tasks
        Task(name: "Design relationships between models",
             mana: 65,
             school: .dataSorcery),
        Task(name: "Implement data filtering",
             mana: 55,
             school: .dataSorcery),
        
        // Hard tasks
        Task(name: "Create complex database queries",
             mana: 95,
             school: .dataSorcery),
        Task(name: "Implement data migration strategy",
             mana: 85,
             school: .dataSorcery)
    ]
    // Temporal Magic Tasks
    static let temporalMagicTasks: [Task] = [
        // Easy tasks
        Task(name: "Study async/await basics",
             mana: 25,
             school: .temporalMagic),
        Task(name: "Implement basic Task handling",
             mana: 30,
             school: .temporalMagic),
        Task(name: "Practice with Timer class",
             mana: 35,
             school: .temporalMagic),
        
        // Medium tasks
        Task(name: "Handle multiple async operations",
             mana: 60,
             school: .temporalMagic),
        Task(name: "Implement custom async sequence",
             mana: 70,
             school: .temporalMagic),
        
        // Hard tasks
        Task(name: "Create complex concurrent systems",
             mana: 90,
             school: .temporalMagic),
        Task(name: "Master actor isolation patterns",
             mana: 100,
             school: .temporalMagic)
    ]
    
    // Transformation Spells Tasks
    static let transformationTasks: [Task] = [
        // Easy tasks
        Task(name: "Apply basic view modifiers",
             mana: 20,
             school: .transformationSpells),
        Task(name: "Create simple custom modifiers",
             mana: 35,
             school: .transformationSpells),
        Task(name: "Practice with transition effects",
             mana: 30,
             school: .transformationSpells),
        
        // Medium tasks
        Task(name: "Build reusable modifier components",
             mana: 55,
             school: .transformationSpells),
        Task(name: "Implement custom transitions",
             mana: 65,
             school: .transformationSpells),
        
        // Hard tasks
        Task(name: "Create complex view transformations",
             mana: 85,
             school: .transformationSpells),
        Task(name: "Master geometry effect modifiers",
             mana: 95,
             school: .transformationSpells)
    ]
    
    // Arcane Studies Tasks
    static let arcaneStudiesTasks: [Task] = [
        // Easy tasks
        Task(name: "Read SwiftUI documentation",
             mana: 25,
             school: .arcaneStudies),
        Task(name: "Study Swift language basics",
             mana: 30,
             school: .arcaneStudies),
        Task(name: "Practice code organization",
             mana: 35,
             school: .arcaneStudies),
        
        // Medium tasks
        Task(name: "Research design patterns",
             mana: 60,
             school: .arcaneStudies),
        Task(name: "Study memory management",
             mana: 70,
             school: .arcaneStudies),
        
        // Hard tasks
        Task(name: "Master advanced Swift concepts",
             mana: 90,
             school: .arcaneStudies),
        Task(name: "Research app architecture patterns",
             mana: 100,
             school: .arcaneStudies)
    ]
    
    // Helper to get all tasks
    static var allTasks: [Task] {
        interfaceEnchantmentTasks +
        dataSorceryTasks +
        temporalMagicTasks +
        transformationTasks +
        arcaneStudiesTasks
    }
}

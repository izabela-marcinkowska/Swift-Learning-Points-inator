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
             school: .interfaceEnchantments,
             difficulty: .easy),
        Task(name: "Style a button with modifiers",
             mana: 25,
             school: .interfaceEnchantments,
             difficulty: .easy),
        
        // Medium tasks
        Task(name: "Create a custom tab view",
             mana: 60,
             school: .interfaceEnchantments,
             difficulty: .medium),
        Task(name: "Implement gesture recognizers",
             mana: 50,
             school: .interfaceEnchantments,
             difficulty: .medium),
        
        // Hard tasks
        Task(name: "Build a complex navigation system",
             mana: 100,
             school: .interfaceEnchantments,
             difficulty: .hard),
        Task(name: "Create a custom chart visualization",
             mana: 90,
             school: .interfaceEnchantments,
             difficulty: .hard)
    ]
    
    // Data Sorcery Tasks
    static let dataSorceryTasks: [Task] = [
        // Easy tasks
        Task(name: "Create a basic SwiftData model",
             mana: 30,
             school: .dataSorcery,
             difficulty: .easy),
        Task(name: "Implement simple CRUD operations",
             mana: 35,
             school: .dataSorcery,
             difficulty: .easy),
        
        // Medium tasks
        Task(name: "Design relationships between models",
             mana: 65,
             school: .dataSorcery,
             difficulty: .medium),
        Task(name: "Implement data filtering",
             mana: 55,
             school: .dataSorcery,
             difficulty: .medium),
        
        // Hard tasks
        Task(name: "Create complex database queries",
             mana: 95,
             school: .dataSorcery,
             difficulty: .hard),
        Task(name: "Implement data migration strategy",
             mana: 85,
             school: .dataSorcery,
             difficulty: .hard)
    ]
    
    // Temporal Magic Tasks
    static let temporalMagicTasks: [Task] = [
        // Easy tasks
        Task(name: "Study async/await basics",
             mana: 25,
             school: .temporalMagic,
             difficulty: .easy),
        Task(name: "Implement basic Task handling",
             mana: 30,
             school: .temporalMagic,
             difficulty: .easy),
        Task(name: "Practice with Timer class",
             mana: 35,
             school: .temporalMagic,
             difficulty: .easy),
        
        // Medium tasks
        Task(name: "Handle multiple async operations",
             mana: 60,
             school: .temporalMagic,
             difficulty: .medium),
        Task(name: "Implement custom async sequence",
             mana: 70,
             school: .temporalMagic,
             difficulty: .medium),
        
        // Hard tasks
        Task(name: "Create complex concurrent systems",
             mana: 90,
             school: .temporalMagic,
             difficulty: .hard),
        Task(name: "Master actor isolation patterns",
             mana: 100,
             school: .temporalMagic,
             difficulty: .hard)
    ]
    
    // Transformation Spells Tasks
    static let transformationTasks: [Task] = [
        // Easy tasks
        Task(name: "Apply basic view modifiers",
             mana: 20,
             school: .transformationSpells,
             difficulty: .easy),
        Task(name: "Create simple custom modifiers",
             mana: 35,
             school: .transformationSpells,
             difficulty: .easy),
        Task(name: "Practice with transition effects",
             mana: 30,
             school: .transformationSpells,
             difficulty: .easy),
        
        // Medium tasks
        Task(name: "Build reusable modifier components",
             mana: 55,
             school: .transformationSpells,
             difficulty: .medium),
        Task(name: "Implement custom transitions",
             mana: 65,
             school: .transformationSpells,
             difficulty: .medium),
        
        // Hard tasks
        Task(name: "Create complex view transformations",
             mana: 85,
             school: .transformationSpells,
             difficulty: .hard),
        Task(name: "Master geometry effect modifiers",
             mana: 95,
             school: .transformationSpells,
             difficulty: .hard)
    ]
    
    // Arcane Studies Tasks
    static let arcaneStudiesTasks: [Task] = [
        // Easy tasks
        Task(name: "Read SwiftUI documentation",
             mana: 25,
             school: .arcaneStudies,
             difficulty: .easy),
        Task(name: "Study Swift language basics",
             mana: 30,
             school: .arcaneStudies,
             difficulty: .easy),
        Task(name: "Practice code organization",
             mana: 35,
             school: .arcaneStudies,
             difficulty: .easy),
        
        // Medium tasks
        Task(name: "Research design patterns",
             mana: 60,
             school: .arcaneStudies,
             difficulty: .medium),
        Task(name: "Study memory management",
             mana: 70,
             school: .arcaneStudies,
             difficulty: .medium),
        
        // Hard tasks
        Task(name: "Master advanced Swift concepts",
             mana: 90,
             school: .arcaneStudies,
             difficulty: .hard),
        Task(name: "Research app architecture patterns",
             mana: 100,
             school: .arcaneStudies,
             difficulty: .hard)
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

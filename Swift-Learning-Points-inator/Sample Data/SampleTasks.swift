//
//  SampleTasks.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation

enum SampleTasks {
    // MARK: - View Alchemy (Crafting Views)
    static let viewAlchemyTasks: [Task] = [
        Task(name: "Learn about stacks in SwiftUI", mana: 15, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Explore view modifiers", mana: 15, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Experiment with SwiftUI gradients", mana: 15, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Practice adding backgrounds and borders", mana: 15, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Learn about creating custom buttons", mana: 50, school: .viewAlchemy, difficulty: .medium),
        Task(name: "Explore conditional views and Group", mana: 50, school: .viewAlchemy, difficulty: .medium),
        Task(name: "Try combining multiple views into a layout", mana: 50, school: .viewAlchemy, difficulty: .medium),
        Task(name: "Experiment with overlays and alignment", mana: 95, school: .viewAlchemy, difficulty: .hard),
        Task(name: "Design a view that adapts to Dark Mode", mana: 100, school: .viewAlchemy, difficulty: .hard),
        Task(name: "Practice creating a complex view hierarchy", mana: 95, school: .viewAlchemy, difficulty: .hard)
    ]
    
    // MARK: - State Sorcery
    static let stateSorceryTasks: [Task] = [
        Task(name: "Learn about @State", mana: 15, school: .stateSorcery, difficulty: .easy),
        Task(name: "Practice using @Binding", mana: 15, school: .stateSorcery, difficulty: .easy),
        Task(name: "Understand ObservableObject", mana: 15, school: .stateSorcery, difficulty: .easy),
        Task(name: "Explore @Published property wrapper", mana: 15, school: .stateSorcery, difficulty: .easy),
        Task(name: "Learn the difference between @ObservedObject and @StateObject", mana: 50, school: .stateSorcery, difficulty: .medium),
        Task(name: "Use @EnvironmentObject across multiple views", mana: 50, school: .stateSorcery, difficulty: .medium),
        Task(name: "Practice combining state from multiple sources", mana: 50, school: .stateSorcery, difficulty: .medium),
        Task(name: "Solve a state synchronization issue", mana: 95, school: .stateSorcery, difficulty: .hard),
        Task(name: "Explore using custom state management patterns", mana: 100, school: .stateSorcery, difficulty: .hard),
        Task(name: "Debug a complex state update problem", mana: 95, school: .stateSorcery, difficulty: .hard)
    ]
    
    // MARK: - Temporal Conjurations
    static let temporalConjurationsTasks: [Task] = [
        Task(name: "Learn the basics of async/await", mana: 15, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Practice using Task for asynchronous work", mana: 15, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Explore Timer and scheduling", mana: 15, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Learn how to sleep a task", mana: 15, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Combine multiple async operations", mana: 50, school: .temporalConjurations, difficulty: .medium),
        Task(name: "Practice cancelling tasks", mana: 50, school: .temporalConjurations, difficulty: .medium),
        Task(name: "Explore using TaskGroup", mana: 50, school: .temporalConjurations, difficulty: .medium),
        Task(name: "Work with async sequences", mana: 95, school: .temporalConjurations, difficulty: .hard),
        Task(name: "Handle complex async data flow", mana: 100, school: .temporalConjurations, difficulty: .hard),
        Task(name: "Debug an async/await issue", mana: 95, school: .temporalConjurations, difficulty: .hard)
    ]
    
    // MARK: - Data Incantations
    static let dataIncantationsTasks: [Task] = [
        Task(name: "Create a SwiftData model", mana: 15, school: .dataIncantations, difficulty: .easy),
        Task(name: "Learn how to save data with SwiftData", mana: 15, school: .dataIncantations, difficulty: .easy),
        Task(name: "Practice fetching data", mana: 15, school: .dataIncantations, difficulty: .easy),
        Task(name: "Add relationships between models", mana: 15, school: .dataIncantations, difficulty: .easy),
        Task(name: "Explore filtering data using predicates", mana: 50, school: .dataIncantations, difficulty: .medium),
        Task(name: "Handle data updates in a SwiftUI view", mana: 50, school: .dataIncantations, difficulty: .medium),
        Task(name: "Learn how to delete objects from SwiftData", mana: 50, school: .dataIncantations, difficulty: .medium),
        Task(name: "Perform a data migration", mana: 95, school: .dataIncantations, difficulty: .hard),
        Task(name: "Optimize SwiftData performance", mana: 100, school: .dataIncantations, difficulty: .hard),
        Task(name: "Debug data persistence problems", mana: 95, school: .dataIncantations, difficulty: .hard)
    ]
    
    // MARK: - Layout Legends
    static let layoutLegendsTasks: [Task] = [
        Task(name: "Learn about HStack and VStack", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Practice with LazyVGrid and LazyHGrid", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Experiment with Spacer and alignment", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Explore GeometryReader", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Create an adaptive layout", mana: 50, school: .layoutLegends, difficulty: .medium),
        Task(name: "Design a layout for different screen sizes", mana: 50, school: .layoutLegends, difficulty: .medium),
        Task(name: "Combine multiple grids and stacks", mana: 50, school: .layoutLegends, difficulty: .medium),
        Task(name: "Solve a layout alignment challenge", mana: 95, school: .layoutLegends, difficulty: .hard),
        Task(name: "Design a layout with nested GeometryReaders", mana: 100, school: .layoutLegends, difficulty: .hard),
        Task(name: "Debug a broken layout", mana: 95, school: .layoutLegends, difficulty: .hard)
    ]
    
    // MARK: - Xcode Arcana (Xcode & Debugging)
    static let xcodeArcanaTasks: [Task] = [
        Task(name: "Explore SwiftUI Previews", mana: 15, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Learn to use breakpoints", mana: 15, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Organize your Xcode project structure", mana: 15, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Explore build settings in Xcode", mana: 15, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Practice using the debugger", mana: 50, school: .xcodeArcana, difficulty: .medium),
        Task(name: "Learn about Instruments for performance testing", mana: 50, school: .xcodeArcana, difficulty: .medium),
        Task(name: "Explore version control (Git) in Xcode", mana: 50, school: .xcodeArcana, difficulty: .medium),
        Task(name: "Analyze a performance bottleneck", mana: 95, school: .xcodeArcana, difficulty: .hard),
        Task(name: "Solve a tricky bug with the debugger", mana: 100, school: .xcodeArcana, difficulty: .hard),
        Task(name: "Explore custom build schemes and configurations", mana: 95, school: .xcodeArcana, difficulty: .hard)
    ]
    
    // MARK: - Animation Enchantments (Motion & Transitions)
    static let animationEnchantmentsTasks: [Task] = [
        Task(name: "Learn about implicit animations", mana: 15, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Practice with the .animation modifier", mana: 15, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Explore withOpacity, scale, and rotation", mana: 15, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Create a simple view transition", mana: 15, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Combine multiple animations", mana: 50, school: .animationEnchantments, difficulty: .medium),
        Task(name: "Learn about spring animations", mana: 50, school: .animationEnchantments, difficulty: .medium),
        Task(name: "Practice animating state changes", mana: 50, school: .animationEnchantments, difficulty: .medium),
        Task(name: "Design a smooth loading animation", mana: 95, school: .animationEnchantments, difficulty: .hard),
        Task(name: "Create a custom transition effect", mana: 100, school: .animationEnchantments, difficulty: .hard),
        Task(name: "Debug animation glitches", mana: 95, school: .animationEnchantments, difficulty: .hard)
    ]
    
    // MARK: - Gesture Mysticism (User Interaction)
    static let gestureMysticismTasks: [Task] = [
        Task(name: "Learn about TapGesture", mana: 15, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Practice using LongPressGesture", mana: 15, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Experiment with DragGesture", mana: 15, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Combine multiple gestures", mana: 15, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Learn about GestureModifiers like .simultaneousGesture", mana: 50, school: .gestureMysticism, difficulty: .medium),
        Task(name: "Practice making custom gestures", mana: 50, school: .gestureMysticism, difficulty: .medium),
        Task(name: "Handle gestures inside ScrollView", mana: 50, school: .gestureMysticism, difficulty: .medium),
        Task(name: "Solve gesture conflicts", mana: 95, school: .gestureMysticism, difficulty: .hard),
        Task(name: "Implement a complex gesture interaction", mana: 100, school: .gestureMysticism, difficulty: .hard),
        Task(name: "Debug gesture recognition issues", mana: 95, school: .gestureMysticism, difficulty: .hard)
    ]
    
    // MARK: - Accessibility Arcanum (Inclusive Design)
    static let accessibilityArcanumTasks: [Task] = [
        Task(name: "Learn about accessibility labels", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Explore VoiceOver navigation in your app", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Practice with Dynamic Type", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Learn about accessibility traits", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Add accessibility hints to your views", mana: 50, school: .accessibilityArcanum, difficulty: .medium),
        Task(name: "Improve color contrast in your app", mana: 50, school: .accessibilityArcanum, difficulty: .medium),
        Task(name: "Test your app with the Accessibility Inspector", mana: 50, school: .accessibilityArcanum, difficulty: .medium),
        Task(name: "Fix a navigation issue with VoiceOver", mana: 95, school: .accessibilityArcanum, difficulty: .hard),
        Task(name: "Customize accessibility actions", mana: 100, school: .accessibilityArcanum, difficulty: .hard),
        Task(name: "Evaluate your app against WCAG standards", mana: 95, school: .accessibilityArcanum, difficulty: .hard)
    ]
    
    // MARK: - Quality Conjurations (Testing & Code Quality)
    static let qualityConjurationsTasks: [Task] = [
        Task(name: "Learn about XCTest basics", mana: 15, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Write a simple unit test", mana: 15, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Explore XCTAssert functions", mana: 15, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Practice testing SwiftUI views", mana: 15, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Learn about snapshot testing", mana: 50, school: .qualityConjurations, difficulty: .medium),
        Task(name: "Write tests for data models", mana: 50, school: .qualityConjurations, difficulty: .medium),
        Task(name: "Practice test-driven development (TDD)", mana: 50, school: .qualityConjurations, difficulty: .medium),
        Task(name: "Debug a failing unit test", mana: 95, school: .qualityConjurations, difficulty: .hard),
        Task(name: "Evaluate test coverage", mana: 100, school: .qualityConjurations, difficulty: .hard),
        Task(name: "Automate tests in a CI/CD pipeline", mana: 95, school: .qualityConjurations, difficulty: .hard)
    ]
    
    // MARK: - File Divination (Data & File Handling)
    static let fileDivinationTasks: [Task] = [
        Task(name: "Learn about Codable and Decodable", mana: 15, school: .fileDivination, difficulty: .easy),
        Task(name: "Parse a simple JSON file", mana: 15, school: .fileDivination, difficulty: .easy),
        Task(name: "Practice writing JSON data", mana: 15, school: .fileDivination, difficulty: .easy),
        Task(name: "Explore FileManager for local files", mana: 15, school: .fileDivination, difficulty: .easy),
        Task(name: "Handle JSON decoding errors", mana: 50, school: .fileDivination, difficulty: .medium),
        Task(name: "Work with Plist files", mana: 50, school: .fileDivination, difficulty: .medium),
        Task(name: "Practice loading remote JSON", mana: 50, school: .fileDivination, difficulty: .medium),
        Task(name: "Debug a parsing error", mana: 95, school: .fileDivination, difficulty: .hard),
        Task(name: "Implement file caching", mana: 100, school: .fileDivination, difficulty: .hard),
        Task(name: "Create a custom encoder/decoder", mana: 95, school: .fileDivination, difficulty: .hard)
    ]
    
    // MARK: - Everyday Endeavors (Personal Tasks)
        static let everydayEndeavorsTasks: [Task] = [
            Task(name: "Plan your daily study goals", mana: 15, school: .everydayEndeavors, difficulty: .easy),
            Task(name: "Organize your Xcode project", mana: 15, school: .everydayEndeavors, difficulty: .easy),
            Task(name: "Review your learning progress", mana: 15, school: .everydayEndeavors, difficulty: .easy),
            Task(name: "Research a SwiftUI topic", mana: 15, school: .everydayEndeavors, difficulty: .easy),
            Task(name: "Write down app ideas", mana: 50, school: .everydayEndeavors, difficulty: .medium),
            Task(name: "Experiment with a personal SwiftUI view", mana: 50, school: .everydayEndeavors, difficulty: .medium),
            Task(name: "Sketch a layout idea", mana: 50, school: .everydayEndeavors, difficulty: .medium),
            Task(name: "Outline a small app feature", mana: 95, school: .everydayEndeavors, difficulty: .hard),
            Task(name: "Prototype a side project", mana: 100, school: .everydayEndeavors, difficulty: .hard),
            Task(name: "Create a reusable custom component", mana: 95, school: .everydayEndeavors, difficulty: .hard)
        ]
    
    // MARK: - All Tasks
    static var allTasks: [Task] {
        return viewAlchemyTasks +
        stateSorceryTasks +
        temporalConjurationsTasks +
        dataIncantationsTasks +
        xcodeArcanaTasks +
        animationEnchantmentsTasks +
        gestureMysticismTasks +
        layoutLegendsTasks +
        accessibilityArcanumTasks +
        qualityConjurationsTasks +
        fileDivinationTasks +
        everydayEndeavorsTasks
    }
}

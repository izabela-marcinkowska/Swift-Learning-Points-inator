//
//  SampleTasks.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation

//
//  SampleTasks.swift
//  Swift-Learning-Points-inator
//
//  Created by [Your Name] on [Today's Date].
//

import Foundation

enum SampleTasks {
    // MARK: - View Alchemy Tasks (Crafting and composing SwiftUI views)
    static let viewAlchemyTasks: [Task] = [
        // Easy Tasks
        Task(name: "Build a Basic Layout with Stacks", mana: 20, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Style a Button with Modifiers", mana: 20, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Integrate an Image into a View", mana: 20, school: .viewAlchemy, difficulty: .easy),
        Task(name: "Create a Simple Text View", mana: 15, school: .viewAlchemy, difficulty: .easy),
        // Medium Tasks
        Task(name: "Compose a Reusable View Component", mana: 45, school: .viewAlchemy, difficulty: .medium),
        Task(name: "Design a Custom Card View", mana: 50, school: .viewAlchemy, difficulty: .medium),
        Task(name: "Implement Conditional Views", mana: 50, school: .viewAlchemy, difficulty: .medium),
        // Hard Tasks
        Task(name: "Create a Responsive Grid Layout", mana: 90, school: .viewAlchemy, difficulty: .hard),
        Task(name: "Build a Complex Nested Layout", mana: 100, school: .viewAlchemy, difficulty: .hard),
        Task(name: "Experiment with Advanced View Modifiers", mana: 95, school: .viewAlchemy, difficulty: .hard)
    ]
    
    // MARK: - State Sorcery Tasks (State management and reactive data flows)
    static let stateSorceryTasks: [Task] = [
        // Easy Tasks
        Task(name: "Experiment with @State Variables", mana: 20, school: .stateSorcery, difficulty: .easy),
        Task(name: "Bind Data Using @Binding", mana: 20, school: .stateSorcery, difficulty: .easy),
        Task(name: "Display Dynamic Text Using State", mana: 15, school: .stateSorcery, difficulty: .easy),
        Task(name: "Toggle a Boolean State", mana: 15, school: .stateSorcery, difficulty: .easy),
        // Medium Tasks
        Task(name: "Manage Data with ObservableObject", mana: 50, school: .stateSorcery, difficulty: .medium),
        Task(name: "Implement an EnvironmentObject", mana: 55, school: .stateSorcery, difficulty: .medium),
        Task(name: "Use @Published for Reactive Updates", mana: 50, school: .stateSorcery, difficulty: .medium),
        // Hard Tasks
        Task(name: "Coordinate Multiple State Sources", mana: 100, school: .stateSorcery, difficulty: .hard),
        Task(name: "Integrate Combine with SwiftUI", mana: 90, school: .stateSorcery, difficulty: .hard),
        Task(name: "Debug Complex State Update Issues", mana: 95, school: .stateSorcery, difficulty: .hard)
    ]
    
    // MARK: - Temporal Conjurations Tasks (Concurrency and time-based operations)
    static let temporalConjurationsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Learn Async/Await Basics", mana: 20, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Schedule a Delayed Operation", mana: 20, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Implement a Simple Timer", mana: 15, school: .temporalConjurations, difficulty: .easy),
        Task(name: "Execute an Async Task", mana: 20, school: .temporalConjurations, difficulty: .easy),
        // Medium Tasks
        Task(name: "Handle Multiple Async Operations", mana: 55, school: .temporalConjurations, difficulty: .medium),
        Task(name: "Manage Task Cancellation", mana: 60, school: .temporalConjurations, difficulty: .medium),
        Task(name: "Build an Async Data Fetcher", mana: 50, school: .temporalConjurations, difficulty: .medium),
        // Hard Tasks
        Task(name: "Implement Task Groups for Concurrency", mana: 100, school: .temporalConjurations, difficulty: .hard),
        Task(name: "Build a Live Data Refresh Mechanism", mana: 95, school: .temporalConjurations, difficulty: .hard),
        Task(name: "Debug Complex Concurrency Issues", mana: 90, school: .temporalConjurations, difficulty: .hard)
    ]
    
    // MARK: - Data Incantations Tasks (Data management and persistence)
    static let dataIncantationsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Create a Basic SwiftData Model", mana: 20, school: .dataIncantations, difficulty: .easy),
        Task(name: "Implement Basic CRUD Operations", mana: 20, school: .dataIncantations, difficulty: .easy),
        Task(name: "Display Data in a List", mana: 15, school: .dataIncantations, difficulty: .easy),
        Task(name: "Simple Data Binding with Models", mana: 15, school: .dataIncantations, difficulty: .easy),
        // Medium Tasks
        Task(name: "Design Relationships Between Models", mana: 55, school: .dataIncantations, difficulty: .medium),
        Task(name: "Persist Data Locally", mana: 50, school: .dataIncantations, difficulty: .medium),
        Task(name: "Integrate JSON Parsing with Models", mana: 55, school: .dataIncantations, difficulty: .medium),
        // Hard Tasks
        Task(name: "Migrate Data Structures", mana: 100, school: .dataIncantations, difficulty: .hard),
        Task(name: "Sync Data with a Remote Server", mana: 95, school: .dataIncantations, difficulty: .hard),
        Task(name: "Optimize Data Queries for Performance", mana: 90, school: .dataIncantations, difficulty: .hard)
    ]
    
    // MARK: - Xcode Arcana Tasks (Xcode tools and project organization)
    static let xcodeArcanaTasks: [Task] = [
        // Easy Tasks
        Task(name: "Explore SwiftUI Previews", mana: 20, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Set Up a New SwiftUI Project", mana: 15, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Customize Build Settings", mana: 20, school: .xcodeArcana, difficulty: .easy),
        Task(name: "Use Breakpoints Effectively", mana: 20, school: .xcodeArcana, difficulty: .easy),
        // Medium Tasks
        Task(name: "Debug a SwiftUI View", mana: 55, school: .xcodeArcana, difficulty: .medium),
        Task(name: "Organize Your Project Structure", mana: 50, school: .xcodeArcana, difficulty: .medium),
        Task(name: "Integrate Version Control", mana: 55, school: .xcodeArcana, difficulty: .medium),
        // Hard Tasks
        Task(name: "Analyze Performance with Instruments", mana: 95, school: .xcodeArcana, difficulty: .hard),
        Task(name: "Run and Interpret Unit Tests", mana: 100, school: .xcodeArcana, difficulty: .hard),
        Task(name: "Customize Xcode for Efficient Workflow", mana: 90, school: .xcodeArcana, difficulty: .hard)
    ]
    
    // MARK: - Animation Enchantments Tasks (Animating your interfaces)
    static let animationEnchantmentsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Animate a Simple View Transition", mana: 20, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Experiment with Implicit Animations", mana: 20, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Animate Opacity Changes", mana: 15, school: .animationEnchantments, difficulty: .easy),
        Task(name: "Scale a View with Animation", mana: 20, school: .animationEnchantments, difficulty: .easy),
        // Medium Tasks
        Task(name: "Create a Custom Animation Curve", mana: 55, school: .animationEnchantments, difficulty: .medium),
        Task(name: "Build a Bouncing Animation", mana: 50, school: .animationEnchantments, difficulty: .medium),
        Task(name: "Combine Multiple Animations", mana: 55, school: .animationEnchantments, difficulty: .medium),
        // Hard Tasks
        Task(name: "Design a Smooth Loading Animation", mana: 95, school: .animationEnchantments, difficulty: .hard),
        Task(name: "Experiment with Spring Animations", mana: 90, school: .animationEnchantments, difficulty: .hard),
        Task(name: "Implement a Delayed Animation Sequence", mana: 100, school: .animationEnchantments, difficulty: .hard)
    ]
    
    // MARK: - Gesture Mysticism Tasks (Handling user interactions)
    static let gestureMysticismTasks: [Task] = [
        // Easy Tasks
        Task(name: "Implement a Tap Gesture", mana: 20, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Add a Drag Gesture to a View", mana: 20, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Detect a Long Press Gesture", mana: 15, school: .gestureMysticism, difficulty: .easy),
        Task(name: "Handle a Swipe Gesture", mana: 20, school: .gestureMysticism, difficulty: .easy),
        // Medium Tasks
        Task(name: "Combine Multiple Gestures", mana: 50, school: .gestureMysticism, difficulty: .medium),
        Task(name: "Create a Custom Gesture Recognizer", mana: 55, school: .gestureMysticism, difficulty: .medium),
        Task(name: "Test Gesture Interactions on a List", mana: 55, school: .gestureMysticism, difficulty: .medium),
        // Hard Tasks
        Task(name: "Handle Simultaneous Gestures", mana: 95, school: .gestureMysticism, difficulty: .hard),
        Task(name: "Refine Gesture Sensitivity", mana: 90, school: .gestureMysticism, difficulty: .hard),
        Task(name: "Implement Advanced Gesture Combinations", mana: 100, school: .gestureMysticism, difficulty: .hard)
    ]
    
    // MARK: - Layout Legends Tasks (Mastering adaptive design and layouts)
    static let layoutLegendsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Build a Responsive Layout with GeometryReader", mana: 20, school: .layoutLegends, difficulty: .easy),
        Task(name: "Experiment with HStack and VStack", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Use Spacers for Adaptive Design", mana: 15, school: .layoutLegends, difficulty: .easy),
        Task(name: "Set a Fixed Frame for a View", mana: 15, school: .layoutLegends, difficulty: .easy),
        // Medium Tasks
        Task(name: "Create a Grid Layout with LazyVGrid", mana: 55, school: .layoutLegends, difficulty: .medium),
        Task(name: "Design a Complex Nested Layout", mana: 55, school: .layoutLegends, difficulty: .medium),
        Task(name: "Implement Conditional Layouts", mana: 50, school: .layoutLegends, difficulty: .medium),
        // Hard Tasks
        Task(name: "Build a Dynamic List Layout", mana: 95, school: .layoutLegends, difficulty: .hard),
        Task(name: "Experiment with Flexible Layouts", mana: 100, school: .layoutLegends, difficulty: .hard),
        Task(name: "Refine a Complex Adaptive Layout", mana: 90, school: .layoutLegends, difficulty: .hard)
    ]
    
    // MARK: - Accessibility Arcanum Tasks (Ensuring apps are accessible)
    static let accessibilityArcanumTasks: [Task] = [
        // Easy Tasks
        Task(name: "Add Accessibility Labels to Views", mana: 20, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Use Accessibility Hints", mana: 20, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Ensure Color Contrast Meets Standards", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        Task(name: "Test Your App with VoiceOver", mana: 15, school: .accessibilityArcanum, difficulty: .easy),
        // Medium Tasks
        Task(name: "Implement Dynamic Type Support", mana: 55, school: .accessibilityArcanum, difficulty: .medium),
        Task(name: "Design Navigation for Accessibility", mana: 50, school: .accessibilityArcanum, difficulty: .medium),
        Task(name: "Integrate Accessibility Traits", mana: 55, school: .accessibilityArcanum, difficulty: .medium),
        // Hard Tasks
        Task(name: "Customize Accessibility Actions", mana: 100, school: .accessibilityArcanum, difficulty: .hard),
        Task(name: "Evaluate Your App with Accessibility Inspector", mana: 95, school: .accessibilityArcanum, difficulty: .hard),
        Task(name: "Refine Accessibility for Complex Layouts", mana: 90, school: .accessibilityArcanum, difficulty: .hard)
    ]
    
    // MARK: - Quality Conjurations Tasks (Testing and quality assurance)
    static let qualityConjurationsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Write Unit Tests for Your Views", mana: 20, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Set Up Snapshot Tests", mana: 20, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Practice Test-Driven Development", mana: 15, school: .qualityConjurations, difficulty: .easy),
        Task(name: "Run Existing Unit Tests", mana: 15, school: .qualityConjurations, difficulty: .easy),
        // Medium Tasks
        Task(name: "Debug Failing Tests", mana: 55, school: .qualityConjurations, difficulty: .medium),
        Task(name: "Integrate UI Testing with XCTest", mana: 50, school: .qualityConjurations, difficulty: .medium),
        Task(name: "Refactor Code for Testability", mana: 55, school: .qualityConjurations, difficulty: .medium),
        // Hard Tasks
        Task(name: "Automate Testing with CI Tools", mana: 100, school: .qualityConjurations, difficulty: .hard),
        Task(name: "Review Test Coverage Reports", mana: 95, school: .qualityConjurations, difficulty: .hard),
        Task(name: "Optimize Performance with Profiling Tools", mana: 90, school: .qualityConjurations, difficulty: .hard)
    ]
    
    // MARK: - File Divination Tasks (File handling and data parsing)
    static let fileDivinationTasks: [Task] = [
        // Easy Tasks
        Task(name: "Parse JSON from a Local File", mana: 20, school: .fileDivination, difficulty: .easy),
        Task(name: "Read Data from a Property List", mana: 20, school: .fileDivination, difficulty: .easy),
        Task(name: "Decode JSON into Models", mana: 15, school: .fileDivination, difficulty: .easy),
        Task(name: "Simple File Reading Operation", mana: 15, school: .fileDivination, difficulty: .easy),
        // Medium Tasks
        Task(name: "Implement a Basic Network Call", mana: 55, school: .fileDivination, difficulty: .medium),
        Task(name: "Handle File Reading Errors", mana: 50, school: .fileDivination, difficulty: .medium),
        Task(name: "Use Codable for File Parsing", mana: 55, school: .fileDivination, difficulty: .medium),
        // Hard Tasks
        Task(name: "Write Data to a File", mana: 100, school: .fileDivination, difficulty: .hard),
        Task(name: "Integrate File Caching", mana: 95, school: .fileDivination, difficulty: .hard),
        Task(name: "Automate File Data Updates", mana: 90, school: .fileDivination, difficulty: .hard)
    ]
    
    // MARK: - Everyday Endeavors Tasks (Personal and day-to-day projects)
    static let everydayEndeavorsTasks: [Task] = [
        // Easy Tasks
        Task(name: "Organize Your Daily Task List", mana: 20, school: .everydayEndeavors, difficulty: .easy),
        Task(name: "Plan a Coding Break Routine", mana: 20, school: .everydayEndeavors, difficulty: .easy),
        Task(name: "Set Up a Personal SwiftUI Project", mana: 15, school: .everydayEndeavors, difficulty: .easy),
        Task(name: "Review Your Daily Progress", mana: 15, school: .everydayEndeavors, difficulty: .easy),
        // Medium Tasks
        Task(name: "Reflect on Your Learning Goals", mana: 50, school: .everydayEndeavors, difficulty: .medium),
        Task(name: "Experiment with a New SwiftUI Idea", mana: 55, school: .everydayEndeavors, difficulty: .medium),
        Task(name: "Document a Personal Project Idea", mana: 50, school: .everydayEndeavors, difficulty: .medium),
        // Hard Tasks
        Task(name: "Schedule Time for Self-Care", mana: 90, school: .everydayEndeavors, difficulty: .hard),
        Task(name: "Explore an App Idea Outside SwiftUI", mana: 95, school: .everydayEndeavors, difficulty: .hard),
        Task(name: "Review and Adjust Your Daily Priorities", mana: 90, school: .everydayEndeavors, difficulty: .hard)
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

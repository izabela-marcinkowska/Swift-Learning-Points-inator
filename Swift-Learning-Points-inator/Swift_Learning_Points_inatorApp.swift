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
            container = try ModelContainer(for: User.self, Task.self)
            
            let modelContext = container.mainContext
            
            let descriptor = FetchDescriptor<Task>()
            let existingTaskCount = try modelContext.fetchCount(descriptor)
            
            if existingTaskCount == 0 {
                [
                    Task(name: "Exploring a new SwiftUI concept", points: 50),
                    Task(name: "Debugging without giving up", points: 75),
                    Task(name: "Reading documentation", points: 30),
                    Task(name: "Completing tutorial sections", points: 40),
                    Task(name: "Writing code from scratch", points: 100)
                ].forEach { task in
                    modelContext.insert(task)
                }
                
                try modelContext.save()
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

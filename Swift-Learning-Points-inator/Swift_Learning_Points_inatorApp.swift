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
                    Task(name: "Exploring a new SwiftUI concept", mana: 50),
                    Task(name: "Debugging without giving up", mana: 75),
                    Task(name: "Reading documentation", mana: 30),
                    Task(name: "Completing tutorial sections", mana: 40),
                    Task(name: "Writing code from scratch", mana: 100)
                ].forEach { task in
                    modelContext.insert(task)
                }
                
                try modelContext.save()
            }
            let userDescriptor = FetchDescriptor<User>()
            let existingUserCount = try modelContext.fetchCount(userDescriptor)
            
            if existingUserCount == 0 {
                let newUser = User(name: "Bella", mana: 0, streak: 0)
                modelContext.insert(newUser)
                try modelContext.save()
            }
            
            if existingUserCount > 0 {
                let users = try modelContext.fetch(userDescriptor)
                if let user = users.first {
                    let status = user.checkStreakStatus()
                    
                    if status == .broken {
                        user.streak = 0
                        user.lastStreakDate = nil
                        try modelContext.save()
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

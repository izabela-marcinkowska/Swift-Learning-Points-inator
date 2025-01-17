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
            container = try ModelContainer(for: User.self, Task.self, SchoolProgress.self)
            
            let modelContext = container.mainContext
            
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

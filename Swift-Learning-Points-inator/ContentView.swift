//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var tasks: [Task]
    var body: some View {
        List(tasks) { task in
            VStack {
            Text(task.name)
            Text("\(task.points)")
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, User.self, configurations: config)
    
    // Insert sample data
    let modelContext = container.mainContext
    let sampleTasks = [
        Task(name: "Learn SwiftUI Animations", points: 60),
        Task(name: "Master SwiftData Basics", points: 80),
        Task(name: "Build Custom Views", points: 45),
        Task(name: "Implement Error Handling", points: 70)
    ]
    
    sampleTasks.forEach { task in
        modelContext.insert(task)
    }
    
    return ContentView()
        .modelContainer(container)
}

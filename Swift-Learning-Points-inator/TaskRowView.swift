//
//  TaskRowView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-13.
//

import SwiftUI
import SwiftData

struct TaskRowView: View {
    let task: Task
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    private var user: User? {
        users.first
    }
    
    var body: some View {
        NavigationLink(destination: DetailTaskView(task: task)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.name)
                    Button("\(task.isCompleted ? "Not completed" : "Completed")") {
                        if let user = user {
                            task.isCompleted.toggle()
                            if task.isCompleted {
                                user.points += task.points
                                user.updateStreak()
                            } else {
                                user.points -= task.points
                            }
                            
                            try? modelContext.save()
                        }
                    }
                    .buttonStyle(.borderless)
                    
                }
                Spacer()
                VStack {
                    Text("\(task.points)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskRowView(task: Task(name: "Sample Task", points: 50))
    }
    .modelContainer(for: [Task.self, User.self], inMemory: true)
}

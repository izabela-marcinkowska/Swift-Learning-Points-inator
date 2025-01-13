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
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: DetailTaskView(task: task)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.name)
                    
                    if task.isCompleted, let completedDate = task.completedDate {
                        Text("Completed: \(completedDate, formatter: dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Button("\(task.isCompleted ? "Not completed" : "Completed")") {
                        if let user = user {
                            task.toggleCompletion(for: user)
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

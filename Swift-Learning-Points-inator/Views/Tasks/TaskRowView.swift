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
    @Query private var spells: [Spell]
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
                    
                    if task.isCompleted, let completedDate = task.lastCompletedDate {
                        Text("Completed: \(completedDate, formatter: dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: task.school.icon)
                        Text(task.school.rawValue)
                    }
                }
                Spacer()
                VStack {
                    Text("\(task.mana)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskRowView(task: Task(name: "Sample Task", mana: 50))
    }
    .modelContainer(for: [Task.self, User.self], inMemory: true)
}

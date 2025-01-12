//
//  DetailTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData



struct DetailTaskView: View {
    @Bindable var task: Task
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    private var user: User? { users.first }
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(task.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("Task is \(task.isCompleted ? "completed" : "not completed")")
            Spacer()
            VStack(spacing: 20) {
                Text("Points:")
                    .font(.title2)
                Text("\(task.points)")
                    .font(.largeTitle)
            }
            Spacer()
            Button ("Mark as \(task.isCompleted ? "not completed" : "completed")") {
                if let user = user {
                    task.isCompleted.toggle()
                    if (task.isCompleted) {
                        user.points += task.points
                        user.updateStreak()
                    } else {
                        user.points -= task.points
                    }
                    
                    try? modelContext.save()
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            TaskFormView(task: task)
        }
    }
}

#Preview {
    NavigationStack {
        DetailTaskView(task: Task(name: "Just random example", points: 75))
    }
    .modelContainer(for: [Task.self, User.self], inMemory: true)
}

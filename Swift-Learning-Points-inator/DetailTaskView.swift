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
    
    var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    
    var body: some View {
            VStack(spacing: 20) {
                Text(task.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Text("Task is \(task.isCompleted ? "completed" : "not completed")")
                    .foregroundColor(task.isCompleted ? .green : .blue)
                
                VStack(spacing: 8) {
                    if task.isCompleted, let completedDate = task.completedDate {
                        Text("Completed:")
                            .font(.headline)
                            .padding(.top, 8)
                        Text(completedDate, formatter: dateFormatter)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.1)))
                
                VStack(spacing: 20) {
                    Text("Points:")
                        .font(.title2)
                    Text("\(task.points)")
                        .font(.largeTitle)
                }
                .padding()
                
                Button("Mark as \(task.isCompleted ? "not completed" : "completed")") {
                    if let user = user {
                        task.toggleCompletion(for: user)
                        try? modelContext.save()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Spacer()
            }
            .padding()
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

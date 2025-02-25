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
    @Query private var spells: [Spell]
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
        VStack(spacing: 24) {
            VStack (spacing: 16) {
                Image(task.school.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                Text(task.name)
                    .font(.title2.bold())
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            
            TaskCompletionStatusView(task: task, dateFormatter: dateFormatter)
            
            TaskManaBreakdownView(task: task, user: user, spells: spells)
            
            VStack(spacing: 12) {
                if !task.isCompleted {
                    Button("Complete Task") {
                        if let user = user {
                            task.completeTaskWithBonus(for: user, spells: spells)
                            try? modelContext.save()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Unmark Task", role: .destructive) {
                        if let user = user {
                            task.unmarkTask(for: user, spells: spells)
                            try? modelContext.save()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
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
        DetailTaskView(task: Task(name: "Just random example", mana: 75))
    }
    .modelContainer(for: [Task.self, User.self], inMemory: true)
}

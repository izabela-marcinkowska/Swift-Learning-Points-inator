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
        VStack(spacing: 20) {
            Text(task.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            HStack {
                Image(systemName: task.school.icon)
                    .font(.title2)
                Text(task.school.rawValue)
                    .font(.title3)
            }
            .padding(.vertical, 8)
            
            TaskCompletionStatusView(task: task, dateFormatter: dateFormatter)
            
            VStack(spacing: 20) {
                Text("Points:")
                    .font(.title2)
                
                let breakdown = task.calculateManaBreakdown(for: user ?? User(), spells: spells)
                
                VStack(spacing: 8) {
                    Text("\(breakdown.baseMana)")
                        .font(.largeTitle)
                    
                    if !breakdown.bonuses.isEmpty {
                        VStack(spacing: 8) {
                            ForEach(breakdown.bonuses, id: \.spell.id) { bonus in
                                HStack {
                                    Image(systemName: bonus.spell.icon)
                                    Text("+\(bonus.amount)")
                                    Text("from \(bonus.spell.name)")
                                }
                                .foregroundStyle(.green)
                                .font(.subheadline)
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            Text("Total: \(breakdown.total)")
                                .font(.headline)
                        }
                    }
                }
            }
            .padding()
            
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

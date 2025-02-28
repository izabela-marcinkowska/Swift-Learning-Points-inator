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
    @Environment(\.dismiss) var dismiss
    private var user: User? { users.first }
    @State private var showingEditSheet = false
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            // Fixed header
            TaskDetailViewHeader(task: task)
                .padding(.bottom, 4)
                .padding(.horizontal)
            
            // Scrollable middle section (cards only)
            ScrollView {
                VStack(spacing: 12) {
                    TaskInfoCard(title: "Status") {
                        TaskCompletionStatusView(task: task, dateFormatter: dateFormatter)
                    }
                    
                    TaskInfoCard(title: "Mana Rewards") {
                        TaskManaBreakdownView(task: task, user: user, spells: spells)
                    }
                    
                    TaskInfoCard(title: "Details") {
                        HStack {
                            // School
                            HStack(spacing: 4) {
                                Image(task.school.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(task.school.rawValue)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            // Difficulty
                            HStack(spacing: 4) {
                                Text("Difficulty:")
                                    .font(.caption)
                                Image(task.difficulty.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(task.difficulty.rawValue)
                                    .font(.caption)
                                    .foregroundColor(task.difficulty.textColor)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            Spacer()
            
            // Fixed button at the bottom
            Button {
                if let user = user {
                    if task.isCompleted {
                        task.unmarkTask(for: user, spells: spells)
                    } else {
                        task.completeTaskWithBonus(for: user, spells: spells)
                    }
                    try? modelContext.save()
                }
            } label: {
                Text(task.isCompleted ? "Unmark Task" : "Complete Task")
                    .font(.headline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(TaskCompletionButtonStyle(isCompleted: task.isCompleted))
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color("background-color"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            TaskFormView(task: task, onDelete: {
                dismiss()
            })
        }
    }
    
    private var completionButton: some View {
        VStack {
            Button(task.isCompleted ? "Unmark Task" : "Complete Task") {
                if let user = user {
                    if task.isCompleted {
                        task.unmarkTask(for: user, spells: spells)
                    } else {
                        task.completeTaskWithBonus(for: user, spells: spells)
                    }
                    try? modelContext.save()
                }
            }
            .buttonStyle(TaskCompletionButtonStyle(isCompleted: task.isCompleted))
            .frame(maxWidth: .infinity, minHeight: 55)
        }
        .padding(.horizontal)
    }
}

struct TaskCompletionButtonStyle: ButtonStyle {
    let isCompleted: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                isCompleted ?
                    LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.7), Color.red]), startPoint: .leading, endPoint: .trailing) :
                    LinearGradient(gradient: Gradient(colors: [Color("button-color").opacity(0.7), Color("button-color")]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: isCompleted ? Color.red.opacity(0.4) : Color("button-color").opacity(0.4), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

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
            TaskDetailViewHeader(task: task)
                .padding(.bottom, 8)
            
            VStack (spacing: 16) {
                
                TaskCompletionStatusView(task: task, dateFormatter: dateFormatter)
                
                TaskManaBreakdownView(task: task, user: user, spells: spells)
            }
            .padding(.horizontal)
            Spacer(minLength: 30)
            
            completionButton
                .padding(.top, 12)
            
        }
        .padding()
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
            TaskFormView(task: task)
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

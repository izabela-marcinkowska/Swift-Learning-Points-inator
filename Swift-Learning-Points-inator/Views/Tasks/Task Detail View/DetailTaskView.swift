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
    @EnvironmentObject private var toastManager: ToastManager
    @EnvironmentObject private var taskNotificationManager: TaskNotificationManager
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            TaskDetailViewHeader(task: task)
                .padding(.bottom, 4)
                .padding(.horizontal)

            ScrollView {
                VStack(spacing: 12) {
                    TaskInfoCardWithoutTitle(task: task) {
                        TaskCompletionStatusView(task: task, dateFormatter: dateFormatter)
                    }
                    
                    TaskInfoCard(title: "Mana Rewards") {
                        TaskManaBreakdownView(task: task, user: user, spells: spells)
                    }
                    
                    TaskInfoCard(title: "Details") {
                        HStack {
                            HStack(spacing: 4) {
                                Image(task.school.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(task.school.rawValue)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
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
                        
                        if task.isRepeatable {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundColor(Color("accent-color"))
                                    .font(.subheadline)
                                
                                Text("Repeatable")
                                    .font(.subheadline)
                                    .foregroundColor(Color("accent-color"))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            Spacer()
            Button {
                if let user = user {
                    if task.isCompleted {
                        task.unmarkTask(for: user, spells: spells)
                        if !modelContext.saveWithErrorHandling(toastManager: toastManager, context: "unmarking task") {
                            task.isCompleted = true
                            return
                        }
                    } else {
                        // Before completing task, check the current level
                        let currentLevel = user.currentLevel(for: task.school)
                        
                        // Complete the task
                        task.completeTaskWithBonus(for: user, spells: spells)
                       
                        if !modelContext.saveWithErrorHandling(toastManager: toastManager, context: "completing task") {
                            task.isCompleted = false
                            return
                        }
                        
                        // Calculate mana breakdown for notification
                        let breakdown = task.calculateManaBreakdown(for: user, spells: spells)
                        
                        // Check if level up occurred
                        let newLevel = user.currentLevel(for: task.school)
                        if newLevel.rawValue > currentLevel.rawValue {
                            // Level up occurred, use the new method
                            taskNotificationManager.reportTaskCompletedWithLevelUp(
                                task: task,
                                mana: breakdown.total,
                                school: task.school,
                                level: newLevel
                            )
                        } else {
                            // No level up, just report task completion as before
                            taskNotificationManager.reportTaskAction(type: .taskCompleted, task: task, mana: breakdown.total)
                        }
                    }
                } else {
                    toastManager.showError(AppError.taskOperation("User data not avaliable."))
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
        .withGradientBackground()
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


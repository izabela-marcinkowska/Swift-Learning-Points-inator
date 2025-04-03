//
//  TasksView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-25.
//

import SwiftUI
import SwiftData

enum TaskViewMode {
    case bySchool
    case byLevel
    case allTasks
}

struct TasksView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var tasks: [Task]
    @State private var showingSheet = false
    @State private var viewMode: TaskViewMode = .bySchool
    @State private var showingFilters = false
    @StateObject private var toastManager = ToastManager()
    
    let columns = [
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var schoolGroups: Dictionary<SchoolOfMagic, [Task]> {
        Dictionary(grouping: tasks, by: { $0.school })
    }
    
    private var difficultyGroups: Dictionary<TaskDifficulty, [Task]> {
        Dictionary(grouping: tasks, by: { $0.difficulty })
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if showingFilters {
                    TasksFilterBar(viewMode: $viewMode)
                }
                
                if viewMode == .allTasks {
                    TaskListContainer(tasks: tasks, showIcon: true, showSchoolName: true)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            if viewMode == .bySchool {
                                TaskSchoolGrid(columns: columns, schoolGroups: schoolGroups)
                            } else {
                                TaskDifficultyGrid(columns: columns, difficultyGroups: difficultyGroups)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            showingFilters.toggle()
                        }
                    } label: {
                        Image(systemName: showingFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .tint(Color("accent-color"))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(Color("accent-color"))
                }
            }
            .sheet(isPresented: $showingSheet) {
                AddTaskWizard(onTaskCreated: { task in
                    toastManager.showTaskCreated(task: task)
                })
                .presentationDetents([.height(450)])
            }
            .withGradientBackground()
            .magicalToast(using: toastManager)
        }
        .tint(Color("accent-color"))
    }
}

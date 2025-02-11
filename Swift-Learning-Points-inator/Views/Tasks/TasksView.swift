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
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
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
                    HStack(spacing: 16) {
                        FilterButton(title: "Schools", icon: "books.vertical", isSelected: viewMode == .bySchool) {
                            viewMode = .bySchool
                        }
                        
                        FilterButton(title: "Level", icon: "chart.bar", isSelected: viewMode == .byLevel) {
                            viewMode = .byLevel
                        }
                        
                        FilterButton(title: "All", icon: "list.bullet", isSelected: viewMode == .allTasks) {
                            viewMode = .allTasks
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.1))
                }
            
            if viewMode == .allTasks {
                TaskListContainer(tasks: tasks)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        if viewMode == .bySchool {
                            ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                                let schoolTasks = schoolGroups[school] ?? []
                                TaskCategoryGridItem(
                                    title: school.rawValue,
                                    icon: school.icon,
                                    count: schoolTasks.count,
                                    tasks: schoolTasks
                                )
                            }
                        } else {
                            ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                                let difficultyTasks = difficultyGroups[difficulty] ?? []
                                TaskCategoryGridItem(
                                    title: difficulty.rawValue,
                                    icon: difficulty.icon,
                                    count: difficultyTasks.count,
                                    tasks: difficultyTasks
                                )
                            }
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
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            AddTaskWizard()
                .presentationDetents([.height(450)])
        }
    }
}
}

struct FilterButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
            Text(title)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color.blue : Color.clear)
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(8)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Task.self,
        User.self,
        configurations: config
    )
    
    let modelContext = container.mainContext
    let sampleTasks = [
        Task(name: "Learn SwiftUI Animations", mana: 60),
        Task(name: "Master SwiftData Basics", mana: 80),
        Task(name: "Build Custom Views", mana: 45),
        Task(name: "Implement Error Handling", mana: 70)
    ]
    
    sampleTasks.forEach { task in
        modelContext.insert(task)
    }
    
    return TasksView()
        .modelContainer(container)
}

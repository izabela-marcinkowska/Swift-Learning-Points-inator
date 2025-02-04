//
//  TasksView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-25.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Query private var tasks: [Task]
    @State private var showingSheet = false
    @Environment(\.modelContext) var modelContext
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            modelContext.delete(task)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section ("Uncompleted tasks") {
                    ForEach(tasks) { task in
                        if (!task.isCompleted) {
                            TaskRowView(task: task)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
                Section ("Completed tasks") {
                    ForEach(tasks) { task in
                        if (task.isCompleted) {
                            TaskRowView(task: task)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                TaskFormView()
            }
        }
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

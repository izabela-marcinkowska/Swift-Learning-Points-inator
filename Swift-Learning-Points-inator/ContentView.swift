//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var tasks: [Task]
    @State private var showingSheet = false
    @Environment(\.modelContext) var modelContext
    
    @Query private var users: [User]
    private var user: User? { users.first }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            // Find the book in the query using the offset
            let task = tasks[offset]
            
            // Delete the book from the model context
            modelContext.delete(task)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section ("Uncomplete tasks") {
                    ForEach(tasks) { task in
                        if (!task.isCompleted) {
                            NavigationLink(
                                destination: DetailTaskView(task: task)
                            ) {
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text(task.name)
                                        Button(
                                            "\(task.isCompleted ? "Not completed" : "Completed")"
                                        ) {
                                            if let user = user {
                                            task.isCompleted.toggle()
                                            task.isCompleted ? (user.points += task.points) : (user.points -= task.points)
                                            try? modelContext.save()
                                            }
                                        }
                                        .buttonStyle(.borderless)
                                    }
                                    Spacer()
                                    VStack {
                                        
                                        Text("\(task.points)")
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                
                Section ("Complated tasks") {
                    ForEach(tasks) { task in
                        if (task.isCompleted) {
                            NavigationLink(
                                destination: DetailTaskView(task: task)
                            ) {
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text(task.name)
                                        Button(
                                            "\(task.isCompleted ? "Not completed" : "Completed")"
                                        ) {
                                            if let user = user {
                                            task.isCompleted.toggle()
                                            task.isCompleted ? (user.points += task.points) : (user.points -= task.points)
                                            try? modelContext.save()
                                            }
                                        }
                                        .buttonStyle(.borderless)
                                    }
                                    Spacer()
                                    VStack {
                                        
                                        Text("\(task.points)")
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    NavigationLink {
                        UserView()
                    } label: {
                        Image(systemName: "person")
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
    
    // Insert sample data
    let modelContext = container.mainContext
    let sampleTasks = [
        Task(name: "Learn SwiftUI Animations", points: 60),
        Task(name: "Master SwiftData Basics", points: 80),
        Task(name: "Build Custom Views", points: 45),
        Task(name: "Implement Error Handling", points: 70)
    ]
    
    sampleTasks.forEach { task in
        modelContext.insert(task)
    }
    
    return ContentView()
        .modelContainer(container)
}

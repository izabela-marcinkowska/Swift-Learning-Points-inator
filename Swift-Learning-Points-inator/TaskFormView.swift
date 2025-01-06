//
//  AddNewTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-30.
//

import SwiftUI
import SwiftData

struct TaskFormView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    let task: Task?
    
    @State var title = ""
    @State var points = 0
    
    init(task: Task? = nil) {
        self.task = task
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && points >= 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                } header: {
                    Text("Title")
                } footer: {
                    Text("Add title to your new task.")
                }
                
                Section {
                    TextField("Points", value: $points, format: .number)
                } header: {
                    Text("Points")
                } footer: {
                    Text("How many points is this task worth?")
                }
            }
            .navigationTitle(task == nil ? "Add new task" : "Edit task")
            .onAppear {
                if let task = task {
                    title = task.name
                    points = task.points
                }
            }
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button(task == nil ? "Add" : "Update") {
                        if let existingTask = task {
                            existingTask.name = title
                            existingTask.points = points
                            try? modelContext.save()
                        } else {
                            let newTask = Task(name: title, points: points)
                            modelContext.insert(newTask)
                            try? modelContext.save()                            
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
}

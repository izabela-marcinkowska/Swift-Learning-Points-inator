//
//  AddNewTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-30.
//

import SwiftUI
import SwiftData

struct AddNewTaskView: View {
    @Bindable var task: Task
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $task.name)
                } header: {
                    Text("Title")
                } footer: {
                    Text("Add title to your new task.")
                }
                
                Section {
                    TextField("Points", value: $task.points, format: .number)
                } header: {
                    Text("Points")
                } footer: {
                    Text("How many points is this task worth?")
                }
            }
            .navigationTitle("Add new task")
        }
    }
}

#Preview {
    AddNewTaskView(task: Task(name: "Just random title", points: 75))
        .modelContainer(for: [Task.self, User.self], inMemory: true)
}

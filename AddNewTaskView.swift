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
                TextField("Title", text: $task.name)
            }
            .navigationTitle("Add new task")
        }
    }
}

#Preview {
    AddNewTaskView(task: Task(name: "Just random example", points: 75))
        .modelContainer(for: [Task.self, User.self], inMemory: true)
}

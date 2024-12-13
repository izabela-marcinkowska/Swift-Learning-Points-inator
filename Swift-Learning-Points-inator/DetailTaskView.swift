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
    var body: some View {
        VStack {
        Text("This is my task:")
        Text(task.name)
            Text("Points: \(task.points)")
        }
    }
}

#Preview {
    DetailTaskView(task: Task(name: "Just random example", points: 75))
        .modelContainer(for: [Task.self, User.self], inMemory: true)
}

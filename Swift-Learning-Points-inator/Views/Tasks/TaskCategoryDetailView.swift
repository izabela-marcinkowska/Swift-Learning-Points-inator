//
//  TaskCategoryDetailView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskCategoryDetailView: View {
    let title: String
    let tasks: [Task]
    
    var body: some View {
        VStack(spacing: 0) {
            // The picture will be showed here
            Rectangle()
                .fill(.gray.opacity(0.1))
                .frame(height: 200)
            
            TaskListContainer(tasks: tasks)
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        TaskCategoryDetailView(
            title: "Data Sorcery",
            tasks: [
                Task(name: "Learn SwiftUI Animations", mana: 60),
                Task(name: "Master SwiftData", mana: 80),
                Task(name: "Practice with async/await", mana: 40)
            ]
        )
    }
}

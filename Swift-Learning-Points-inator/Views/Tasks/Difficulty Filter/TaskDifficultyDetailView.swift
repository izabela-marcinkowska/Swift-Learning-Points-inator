//
//  TaskDifficultyDetailView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-24.
//

import SwiftUI

struct TaskDifficultyDetailView: View {
    let tasks: [Task]
    let difficulty: TaskDifficulty
    
    var body: some View {
        VStack (spacing: 0) {
            
            DifficultyHeaderView(difficulty: difficulty)
            
            TaskListContainer(tasks: tasks, showIcon: true, showSchoolName: true)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("background-color"),
                    Color("background-color").opacity(0.9),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
}


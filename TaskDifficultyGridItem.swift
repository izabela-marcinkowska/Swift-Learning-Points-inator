//
//  TaskDifficultyGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-23.
//

import SwiftUI

struct TaskDifficultyGridItem: View {
    let difficulty: TaskDifficulty
    let count: Int
    let tasks: [Task]
    
    var body: some View {
        NavigationLink(destination: TaskListContainer(tasks: tasks)) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(difficulty.rawValue)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text("\(count) tasks")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Image(systemName: difficulty.icon)
                    .font(.system(size: 32))
            }
            .padding()
            .frame(height: 140)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}


//
//  TaskDifficultyGrid.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-18.
//

import SwiftUI

struct TaskDifficultyGrid: View {
    let columns: [GridItem]
    let difficultyGroups: [TaskDifficulty: [Task]]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                let difficultyTasks = difficultyGroups[difficulty] ?? []
                TaskCategoryGridItem(
                    title: difficulty.rawValue,
                    icon: difficulty.icon,
                    count: difficultyTasks.count,
                    tasks: difficultyTasks
                )
            }
            .frame(maxWidth: .infinity)
        }
    }
}

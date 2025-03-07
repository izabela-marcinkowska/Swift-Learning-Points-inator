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
        NavigationLink(destination: TaskDifficultyDetailView(tasks: tasks, difficulty: difficulty)) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(difficulty.rawValue)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Text("\(count) tasks")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.55, alignment: .leading)
                
                Image(difficulty.icon)
                    .resizable()
                    .scaledToFit()
                    .padding(22)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 140)
            .withCardStyle()
        }
    }
}


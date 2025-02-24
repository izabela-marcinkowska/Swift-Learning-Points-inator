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
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("card-background"),
                        Color("card-background").opacity(0.9),
                        Color.black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
        }
    }
}


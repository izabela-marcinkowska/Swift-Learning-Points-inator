//
//  TaskCategoryGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskCategoryGridItem: View {
    let title: String
    let icon: String
    let count: Int
    let tasks: [Task]
    
    var body: some View {
        NavigationLink(destination: TaskCategoryDetailView(title: title, tasks: tasks)) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
                
                Text("\(count) tasks")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .frame(height: 120)
            .background(Color("card-background"))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TaskCategoryGridItem(
        title: "Data Sorcery",
        icon: "wand.and.rays",
        count: 2,
        tasks: [  // Add sample tasks for preview
            Task(name: "Learn SwiftData", mana: 60),
            Task(name: "Practice Queries", mana: 40)
        ]
    )
    .frame(width: 170)
    .padding()
}

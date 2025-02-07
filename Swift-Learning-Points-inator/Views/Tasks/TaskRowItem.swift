//
//  TaskRowItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskRowItem: View {
    let task: Task
    
    var body: some View {
        NavigationLink(destination: DetailTaskView(task: task)) {
            HStack {
                Image(systemName: task.school.icon)
                    .font(.title2)
                    .foregroundStyle(.blue)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.name)
                        .font(.headline)
                    
                    Text(task.school.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "diamond.fill")
                        .font(.caption)
                    Text("\(task.mana)")
                        .font(.headline)
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TaskRowItem(task: Task(
            name: "Learn SwiftUI Animations",
            mana: 60,
            school: .interfaceEnchantments,
            difficulty: .medium
        ))
        .padding()
    }
}

//
//  RecentTasksView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-17.
//

import SwiftUI

struct RecentTasksView: View {
    let tasks: [Task]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Tasks")
                .font(.headline)
            
            ForEach (tasks) { task in
                NavigationLink(destination: DetailTaskView(task: task)) {
                    RecentTaskItem(task: task)
                }
                .buttonStyle(.plain)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//
//  TasksFilterBar.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-18.
//

import SwiftUI

struct TasksFilterBar: View {
    @Binding var viewMode: TaskViewMode
    
    var body: some View {
        HStack(spacing: 16) {
            FilterButton(title: "Schools", icon: "books.vertical", isSelected: viewMode == .bySchool) {
                viewMode = .bySchool
            }
            
            FilterButton(title: "Level", icon: "chart.bar", isSelected: viewMode == .byLevel) {
                viewMode = .byLevel
            }
            
            FilterButton(title: "All", icon: "list.bullet", isSelected: viewMode == .allTasks) {
                viewMode = .allTasks
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

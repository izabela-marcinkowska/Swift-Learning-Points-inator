//
//  TaskRowItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskRowItem: View {
    let task: Task
    let showIcon: Bool
    let showSchoolName: Bool
    
    var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    
    var body: some View {
        NavigationLink(destination: DetailTaskView(task: task)) {
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.name)
                            .font(.headline)
                        
                        HStack {
                            if showIcon {
                            Image(task.school.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                            }
                            if showSchoolName {
                                
                            Text(task.school.rawValue)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        Image("diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                        Text("\(task.mana)")
                            .font(.subheadline)
                    }
                }
                
                if task.isCompleted, let completedDate = task.lastCompletedDate {
                    HStack {
                        Spacer()
                        Text("Completed: \(completedDate, formatter: dateFormatter)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

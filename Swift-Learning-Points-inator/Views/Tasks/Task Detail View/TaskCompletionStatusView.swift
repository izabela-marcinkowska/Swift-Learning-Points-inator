//
//  TaskCompletionStatusView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-17.
//

import SwiftUI

struct TaskCompletionStatusView: View {
    let task: Task
    let dateFormatter: DateFormatter
    
    var body: some View {
        HStack(spacing: 16) {
            // Status and repeatable info
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .blue)
                        .font(.title3)
                    
                    Text(task.isCompleted ? "Completed" : "Not Completed")
                        .foregroundColor(task.isCompleted ? .green : .blue)
                }
                
                if task.isRepeatable {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                        Text("Repeatable")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Spacer()
            
            // Date info (if completed)
            if task.isCompleted, let completedDate = task.lastCompletedDate {
                VStack(alignment: .trailing) {
                    Text("Completed on:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(completedDate, formatter: dateFormatter)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

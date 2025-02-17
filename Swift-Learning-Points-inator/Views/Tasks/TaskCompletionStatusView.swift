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
        VStack {
            Text("Task is \(task.isCompleted ? "completed" : "not completed")")
                .foregroundColor(task.isCompleted ? .green : .blue)
            
            if task.isCompleted, let completedDate = task.lastCompletedDate {
                    VStack(spacing: 8) {
                    Text("Completed:")
                        .font(.headline)
                        .padding(.top, 8)
                    Text(completedDate, formatter: dateFormatter)
                        .foregroundColor(.green)
                }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1)))
            }
        }
    }
}

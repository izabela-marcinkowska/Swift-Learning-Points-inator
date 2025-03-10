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
        VStack (spacing: 8) {
                Text(task.isCompleted ? "Completed" : "Not Completed")
                .foregroundColor(task.isCompleted ? Color("accent-color") : Color("progress-color").opacity(0.6))

                if task.isCompleted, let completedDate = task.lastCompletedDate {
                    HStack (spacing: 2) {
                        Text("Completed on:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(completedDate, formatter: dateFormatter)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } 
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
}

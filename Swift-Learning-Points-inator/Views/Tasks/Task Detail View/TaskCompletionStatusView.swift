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
        VStack(alignment: .center) {
                
                Text(task.isCompleted ? "Completed" : "Not Completed")
                    .foregroundColor(task.isCompleted ? .green : Color("progress-color"))
                
                if task.isCompleted, let completedDate = task.lastCompletedDate {
                    HStack {
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

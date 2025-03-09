//
//  RecentTaskItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-17.
//

import SwiftUI

struct RecentTaskItem: View {
    let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            Image(task.school.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                
                if let completedDate = task.lastCompletedDate {
                    Text(completedDate, formatter: dateFormatter)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Image("diamond")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                Text("\(task.mana)")
                    .font(.subheadline)
            }
            
        }
        .padding()
    }
}

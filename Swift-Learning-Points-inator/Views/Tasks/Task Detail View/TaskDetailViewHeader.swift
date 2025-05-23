//
//  TaskDetailViewHeader.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-25.
//

import SwiftUI

struct TaskDetailViewHeader: View {
    let task: Task
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Image(task.school.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
            }
            
            Text(task.name)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

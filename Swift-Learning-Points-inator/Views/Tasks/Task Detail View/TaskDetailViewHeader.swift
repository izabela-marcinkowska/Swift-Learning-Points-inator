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
        VStack (spacing: 16) {
            Image(task.school.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            Text(task.name)
                .font(.title2.bold())
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

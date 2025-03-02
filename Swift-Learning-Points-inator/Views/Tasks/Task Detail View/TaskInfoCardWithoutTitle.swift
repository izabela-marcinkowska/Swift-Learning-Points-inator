//
//  TaskInfoCardWithoutTitle.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-01.
//

import SwiftUI

struct TaskInfoCardWithoutTitle<Content: View>: View {
    let content: Content
    let task: Task
    
    init(task: Task, @ViewBuilder content: () -> Content) {
        self.task = task
        self.content = content()
    }
    
    var body: some View {
        VStack() {
            content
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(task.isCompleted ? Color("card-background") : Color("card-background").opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: task.isCompleted ? Color("shadow-card").opacity(0.3) : Color("shadow-card").opacity(0) , radius: 5, x: 0, y: 2)
    }
}

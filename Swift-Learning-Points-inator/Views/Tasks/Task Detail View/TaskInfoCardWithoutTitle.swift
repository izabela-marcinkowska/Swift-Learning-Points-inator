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
        .withCardStyle(useGradient: false)
    }
}

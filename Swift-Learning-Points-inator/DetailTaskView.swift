//
//  DetailTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData



struct DetailTaskView: View {
    @Bindable var task: Task
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text("Points:")
                    .font(.title2)
                Text("\(task.points)")
                    .font(.largeTitle)
            }
            Spacer()
            Spacer()
        }
        .navigationBarTitle(task.name)
    }
}

#Preview {
    DetailTaskView(task: Task(name: "Just random example", points: 75))
        .modelContainer(for: [Task.self, User.self], inMemory: true)
}

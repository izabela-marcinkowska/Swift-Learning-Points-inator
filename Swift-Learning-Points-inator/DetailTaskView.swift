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
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(task.name)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            TaskFormView(task: task)
        }
    }
}

#Preview {
    NavigationStack {
        DetailTaskView(task: Task(name: "Just random example", points: 75))
    }
    .modelContainer(for: [Task.self, User.self], inMemory: true)
}

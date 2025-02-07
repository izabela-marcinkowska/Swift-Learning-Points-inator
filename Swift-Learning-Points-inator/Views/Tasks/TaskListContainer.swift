//
//  TaskList.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskListContainer: View {
    let tasks: [Task]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(tasks) { task in
                    TaskRowItem(task: task)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    NavigationStack {
        TaskListContainer(tasks: [
            Task(name: "Learn SwiftUI Animations", mana: 60, school: .interfaceEnchantments),
            Task(name: "Master SwiftData", mana: 80, school: .dataSorcery),
            Task(name: "Practice with async/await", mana: 40, school: .temporalMagic),
            Task(name: "Build custom modifiers", mana: 50, school: .transformationSpells)
        ])
    }
}

//
//  TaskList.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskListContainer: View {
    let tasks: [Task]
    let showIcon: Bool
    let showSchoolName: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(tasks) { task in
                    TaskRowItem(task: task, showIcon: showIcon, showSchoolName: showSchoolName)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}


//
//  TaskCategoryDetailView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskCategoryDetailView: View {
    let school: SchoolOfMagic
    let tasks: [Task]
    
    var body: some View {
        VStack(spacing: 0) {
            SchoolHeaderView(school: school)
            
            TaskListContainer(tasks: tasks, showIcon: false, showSchoolName: false)
        }
        .background(Color("background-color"))
    }
}

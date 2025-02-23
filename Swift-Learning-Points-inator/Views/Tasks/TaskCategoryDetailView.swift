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
            // The picture will be showed here
            Image(school.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            TaskListContainer(tasks: tasks)
        }
        .navigationTitle(school.rawValue)
        .background(Color("card-background"))
    }
}

//
//  TaskSchoolGrid.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-18.
//

import SwiftUI

struct TaskSchoolGrid: View {
    let columns: [GridItem]
    let schoolGroups: [SchoolOfMagic: [Task]]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                let schoolTasks = schoolGroups[school] ?? []
                TaskCategoryGridItem(
                    title: school.rawValue,
                    icon: school.icon,
                    count: schoolTasks.count,
                    tasks: schoolTasks,
                    school: school,
                    imageName: school.imageName
                )
            }
            .frame(maxWidth: .infinity)
        }
    }
}

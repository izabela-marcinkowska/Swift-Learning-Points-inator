//
//  DetailSchoolView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-21.
//

import SwiftUI
import SwiftData

struct DetailSchoolView: View {
    let school: SchoolOfMagic
    @Query private var tasks: [Task]
    
    private var uncompletedTasks: [Task] {
        tasks.filter {$0.school == school && !$0.isCompleted}
    }
    
    private var completedTasks: [Task] {
        tasks.filter {$0.school == school && $0.isCompleted}
    }
    
    var body: some View {
            List {
                // Header Section
                Section {
                    VStack(alignment: .center, spacing: 20) {
                        Image(systemName: school.icon)
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text(school.description)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                
                // Uncompleted Tasks Section
                if !uncompletedTasks.isEmpty {
                    Section("Uncompleted Tasks") {
                        ForEach(uncompletedTasks) { task in
                            TaskRowView(task: task)
                        }
                    }
                }
                
                // Completed Tasks Section
                if !completedTasks.isEmpty {
                    Section("Completed Tasks") {
                        ForEach(completedTasks) { task in
                            TaskRowView(task: task)
                        }
                    }
                }
            }
            .navigationTitle(school.rawValue)
        }
}
#Preview {
    NavigationStack {
        DetailSchoolView(school: .dataSorcery)
    }
}

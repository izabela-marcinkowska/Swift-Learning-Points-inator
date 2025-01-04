//
//  AddNewTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-30.
//

import SwiftUI
import SwiftData

struct AddNewTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var points = 0
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && points >= 0
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                } header: {
                    Text("Title")
                } footer: {
                    Text("Add title to your new task.")
                }
                
                Section {
                    TextField("Points", value: $points, format: .number)
                } header: {
                    Text("Points")
                } footer: {
                    Text("How many points is this task worth?")
                }
            }
            .navigationTitle("Add new task")
            .toolbar {
                Button("Save") {
                    let newTask = Task(name: title, points: points)
                    modelContext.insert(newTask)
                    try? modelContext.save()
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
}

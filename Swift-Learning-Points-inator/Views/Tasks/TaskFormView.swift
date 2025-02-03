//
//  AddNewTaskView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-30.
//

import SwiftUI
import SwiftData

struct TaskFormView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    let task: Task?
    
    @State var title = ""
    @State var mana = 0
    @State private var selectedSchool: SchoolOfMagic = .arcaneStudies
    @State private var isRepeatable = false
    
    init(task: Task? = nil) {
        self.task = task
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && mana >= 0
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
                    TextField("Mana", value: $mana, format: .number)
                } header: {
                    Text("Mana")
                } footer: {
                    Text("How much mana is this task worth?")
                }
                
                Section {
                    Toggle("Repeatable", isOn: $isRepeatable)
                } footer: {
                    Text("Repeatable tasks can be completed once per day")
                }
                
                Section {
                    Picker("School of magic", selection: $selectedSchool) {
                        ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                            HStack {
                                Image(systemName: school.icon)
                                Text(school.rawValue)
                            }.tag(school)
                            
                        }
                    }
                } header: {
                    Text("School of magic")
                } footer: {
                    Text("Select which school this task belongs to")
                }
            }
            .navigationTitle(task == nil ? "Add new task" : "Edit task")
            .onAppear {
                if let task = task {
                    title = task.name
                    mana = task.mana
                    selectedSchool = task.school
                    isRepeatable = task.isRepeatable
                }
            }
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button(task == nil ? "Add" : "Update") {
                        if let existingTask = task {
                            existingTask.name = title
                            existingTask.mana = mana
                            existingTask.school = selectedSchool
                            existingTask.isRepeatable = isRepeatable
                            do {
                                try modelContext.save()
                            } catch {
                                print("Error saving context: \(error)")
                            }
                        } else {
                            let newTask = Task(name: title, mana: mana, school: selectedSchool, isRepeatable: isRepeatable)
                            modelContext.insert(newTask)
                            do {
                                try modelContext.save()
                            } catch {
                                print("Error saving context: \(error)")
                            }
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
}

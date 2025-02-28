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
    @State private var selectedSchool: SchoolOfMagic = .everydayEndeavors
    @State private var isRepeatable = false
    
    init(task: Task? = nil) {
        self.task = task
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty && mana >= 0
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                    } header: {
                        Text("Title")
                    } footer: {
                        Text("Add title to your new task.")
                    }
                    .listRowBackground(Color("card-background"))
                    
                    Section {
                        TextField("Mana", value: $mana, format: .number)
                    } header: {
                        Text("Mana")
                    } footer: {
                        Text("How much mana is this task worth?")
                    }
                    .listRowBackground(Color("card-background"))
                    
                    Section {
                        Toggle("Repeatable", isOn: $isRepeatable)
                    } footer: {
                        Text("Repeatable tasks can be completed once per day")
                    }
                    .listRowBackground(Color("card-background"))
                    .tint(Color("progress-color"))
                    
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
                    .listRowBackground(Color("card-background"))
                    .tint(Color("progress-color"))
                }
                .scrollContentBackground(.hidden)
                .background(Color("background-color"))
                
                Button ("Update task") {
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
                .buttonStyle(TaskUpdateButtonStyle())
                .frame(maxWidth: .infinity, minHeight: 55)
                .disabled(!isFormValid)
                .padding(.horizontal)
                
                
            }
            .background(Color("background-color"))
            .onAppear {
                if let task = task {
                    title = task.name
                    mana = task.mana
                    selectedSchool = task.school
                    isRepeatable = task.isRepeatable
                }
            }
            
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color("progress-color"))
                            .font(.title2)
                    }
                    .padding(.top, 3)
                }
                
            }
            .navigationTitle("Edit task")
        }
    }
}

struct TaskUpdateButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("button-color").opacity(0.7), Color("button-color")]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(color: Color("button-color").opacity(0.4), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

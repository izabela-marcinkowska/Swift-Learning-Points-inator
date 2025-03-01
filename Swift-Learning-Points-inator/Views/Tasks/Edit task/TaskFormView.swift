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
    var onDelete: (() -> Void)? = nil
    
    @State var title = ""
    @State var mana = 0
    @State private var selectedSchool: SchoolOfMagic = .everydayEndeavors
    @State private var isRepeatable = false
    @State private var selectedDifficulty: TaskDifficulty = .easy
    @State private var showDeleteAlert = false
    
    init(task: Task? = nil, onDelete: (() -> Void)? = nil) {
        self.task = task
        self.onDelete = onDelete
    }
    
    private func deleteTask() {
        if let task = task {
            modelContext.delete(task)
            try? modelContext.save()
            dismiss()
            onDelete?()
        }
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
                    }
                    .listRowBackground(Color("card-background"))
                    
                    Section {
                        SchoolPickerView(selectedSchool: $selectedSchool)
                    } header: {
                        Text("School of magic")
                    } footer: {
                        Text("Select which school this task belongs to")
                    }
                    .listRowBackground(Color("card-background"))
                    .tint(Color("progress-color"))
                    
                    Section {
                        DifficultyPickerView(selectedDifficulty: $selectedDifficulty, mana: $mana)
                    } header: {
                        Text("Difficulty")
                    } footer: {
                        Text("Task difficulty affects mana range")
                    }
                    .listRowBackground(Color("card-background"))
                    .tint(selectedDifficulty.textColor)
                    
                    Section {
                        ManaSliderView(mana: $mana, difficulty: selectedDifficulty)
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
                    
                    if task != nil {
                        Section {
                            Button(role: .destructive) {
                                showDeleteAlert = true
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Delete task")
                                    Spacer()
                                }
                            }
                        }
                        .listRowBackground(Color("card-background"))
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .background(Color("background-color"))
                
                Button ("Update task") {
                    if let existingTask = task {
                        existingTask.name = title
                        existingTask.mana = mana
                        existingTask.school = selectedSchool
                        existingTask.isRepeatable = isRepeatable
                        existingTask.difficulty = selectedDifficulty
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
                    selectedDifficulty = task.difficulty
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
            .alert("Delete Task", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteTask()
                }
            } message: {
                Text("Are you sure you want to delete this task? This action cannot be undone.")
            }
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


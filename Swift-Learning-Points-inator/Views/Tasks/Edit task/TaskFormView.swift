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
    var onTaskUpdated: ((Task) -> Void)?
    @EnvironmentObject private var taskNotificationManager: TaskNotificationManager
    @EnvironmentObject var toastManager: ToastManager
    
    
    @State var title = ""
    @State var mana = 0
    @State private var selectedSchool: SchoolOfMagic = .everydayEndeavors
    @State private var isRepeatable = false
    @State private var selectedDifficulty: TaskDifficulty = .easy
    @State private var deleteAlertModel: MagicalAlertModel? = nil
    
    init(task: Task? = nil, onDelete: (() -> Void)? = nil, onTaskUpdated: ((Task) -> Void)? = nil) {
        self.task = task
        self.onDelete = onDelete
        self.onTaskUpdated = onTaskUpdated
    }
    
    /// Deletes the currently selected task from the data store.
    ///
    /// This function removes the existing task from the persistent storage:
    /// 1. Confirms a task is available for deletion
    /// 2. Deletes the task and persists the change
    /// 3. Reports the deletion to the notification system
    /// 4. Dismisses the current view
    ///
    /// - Note: This operation only proceeds if a valid task exists
    private func deleteTask() {
        if let task = task {
            
            if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "deleting task") {
                taskNotificationManager.reportTaskAction(type: .taskDeleted, task: task)
                dismiss()
                onDelete?()
            }
        }
    }
    
    /// Updates an existing task or creates a new one based on the current form state.
    ///
    /// This function handles two distinct paths:
    /// - For existing tasks: Updates all properties with current form values
    /// - For new tasks: Creates a fresh Task instance with the form values
    ///
    /// In both cases, the function:
    /// 1. Persists the changes to storage
    /// 2. Reports the appropriate action to the notification system
    /// 3. Dismisses the current view
    /// 4. Triggers the appropriate completion callback
    ///
    /// - Note: The behavior changes based on whether `task` property contains a value
    private func updateTask() {
        if let existingTask = task {
            existingTask.name = title
            existingTask.mana = mana
            existingTask.school = selectedSchool
            existingTask.isRepeatable = isRepeatable
            existingTask.difficulty = selectedDifficulty
           
            if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "updating task") {
                taskNotificationManager.reportTaskAction(type: .taskUpdated, task: existingTask)
                dismiss()
                onTaskUpdated?(existingTask)
            }
            
        } else {
            let newTask = Task(name: title, mana: mana, school: selectedSchool, isRepeatable: isRepeatable, difficulty: selectedDifficulty)
            modelContext.insert(newTask)
            taskNotificationManager.reportTaskAction(type: .taskCreated, task: newTask)
            
            if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "creating task") {
                taskNotificationManager.reportTaskAction(type: .taskCreated, task: newTask)
                dismiss()
            }
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
                                deleteAlertModel = MagicalAlertModel.confirmation(
                                    title: "Delete Task",
                                    message: "Are you sure you want to delete this task? This action cannot be undone.",
                                    confirmText: "Delete",
                                    cancelText: "Cancel",
                                    onConfirm: {
                                        deleteTask()
                                    }
                                )
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
                
                MagicalButton(
                    text: "Update task",
                    isEnabled: isFormValid,
                    action: updateTask
                )
                .padding(.horizontal)
                .padding(.vertical, 10)
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
            .magicalAlert(isPresented: $deleteAlertModel)
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
            .toolbarBackground(Color("background-color"), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

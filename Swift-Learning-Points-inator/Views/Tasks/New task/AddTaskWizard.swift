//
//  AddTaskWizard.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-11.
//

import SwiftUI

struct TaskFormData {
    var title: String = ""
    var description: String = ""
    var difficulty: TaskDifficulty = .easy
    var mana: Int = 0
    var isRepeatable: Bool = false
    var school: SchoolOfMagic = .everydayEndeavors
}

struct AddTaskWizard: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var onTaskCreated: ((Task) -> Void)?
    @EnvironmentObject private var taskNotificationManager: TaskNotificationManager
    @EnvironmentObject var toastManager: ToastManager
    
    @State private var currentStep = 0
    @State private var formData = TaskFormData()
    
    @State private var movingForward = true
    
    private var isCurrentStepValid: Bool {
        switch currentStep {
        case 0: // Title step
            return !formData.title.trimmingCharacters(in: .whitespaces).isEmpty
        case 1: // School and difficulty step
            // Default values should be valid, so we return true here
            return true
        case 2: // Additional options step
            return true
        default:
            return false
        }
    }
    
    /// Creates and persists a new task based on the current form data.
    ///
    /// This function handles the complete process of task creation:
    /// 1. Constructs a new Task instance using the validated form data
    /// 2. Inserts the task into the model context
    /// 3. Persists the changes to storage
    /// 4. Notifies listeners about the newly created task
    ///
    /// - Note: On success, this function will dismiss the current view
    private func createTask() {
        let newTask = Task(
            name: formData.title,
            mana: formData.mana,
            school: formData.school,
            isRepeatable: formData.isRepeatable,
            difficulty: formData.difficulty
        )
        modelContext.insert(newTask)
        
        if modelContext.saveWithErrorHandling(toastManager: toastManager, context: "creating task") {
            dismiss()
            onTaskCreated?(newTask)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ZStack {
                    if currentStep == 0 {
                        TaskWizardStepOne(formData: $formData)
                            .transition(.asymmetric(
                                insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                                removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                            ))
                            .zIndex(currentStep == 0 ? 1 : 0) 
                    } else if currentStep == 1 {
                        TaskWizardStepTwo(formData: $formData)
                            .transition(.asymmetric(
                                insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                                removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                            ))
                            .zIndex(currentStep == 1 ? 1 : 0)
                    } else if currentStep == 2 {
                        TaskWizardStepThree(formData: $formData)
                            .transition(.asymmetric(
                                insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                                removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                            ))
                            .zIndex(currentStep == 2 ? 1 : 0)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
                .animation(.easeInOut(duration: 0.3), value: currentStep)
                
                VStack(spacing: 16) {
                    Button {
                        if currentStep < 2 {
                            movingForward = true
                            withAnimation {
                                currentStep += 1
                            }
                        } else {
                            createTask()
                        }
                    } label: {
                        Text(currentStep == 2 ? "Create task" : "Next")
                            .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color("button-color").opacity(0.7), Color("button-color")]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color("button-color").opacity(0.4), radius: 4, x: 0, y: 2)
                                    .opacity(isCurrentStepValid ? 1.0 : 0.6)
                    }
                    .disabled(!isCurrentStepValid)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(currentStep == index ? Color("accent-color") : Color.gray.opacity(0.3))
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentStep > 0 {
                        Button {
                            movingForward = false
                            withAnimation {
                                currentStep -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(Color("accent-color"))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(Color("accent-color"))
                    }
                }
            }
            .background(Color("background-color"))
        }
    }
}

#Preview {
    AddTaskWizard()
}

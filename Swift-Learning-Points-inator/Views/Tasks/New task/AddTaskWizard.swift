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
    
    @State private var currentStep = 0
    @State private var formData = TaskFormData()
    
    @State private var movingForward = true
    
    private var isCurrentStepValid: Bool {
        switch currentStep {
        case 0:
            return !formData.title.trimmingCharacters(in: .whitespaces).isEmpty
        case 1:
            return formData.mana > 0
        case 2:
            return true
        default:
            return false
        }
    }
    
    private func createTask() {
        let newTask = Task(
            name: formData.title,
            mana: formData.mana,
            school: formData.school,
            isRepeatable: formData.isRepeatable,
            difficulty: formData.difficulty
        )
        modelContext.insert(newTask)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving content: \(error)")
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
                    }
                    else if currentStep == 1 {
                        TaskWizardStepTwo(formData: $formData)
                            .transition(.asymmetric(
                                insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                                removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                            ))
                    }
                    else if currentStep == 2 {
                        TaskWizardStepThree(formData: $formData)
                            .transition(.asymmetric(
                                insertion: movingForward ? .move(edge: .trailing) : .move(edge: .leading),
                                removal: movingForward ? .move(edge: .leading) : .move(edge: .trailing)
                            ))
                    }
                }
                .animation(.default, value: currentStep)
                
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
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .disabled(!isCurrentStepValid)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(currentStep == index ? Color.blue : Color.gray)
                                .frame(width: 8, height: 8)
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
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskWizard()
}

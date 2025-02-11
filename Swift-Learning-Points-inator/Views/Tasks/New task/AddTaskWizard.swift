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
    var school: SchoolOfMagic = .arcaneStudies
}

struct AddTaskWizard: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var currentStep = 0
    @State private var formData = TaskFormData()
    
    private var isStepOneValid: Bool {
        !formData.title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isStepTwoValid: Bool {
        formData.mana > 0
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
        dismiss()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Create new task")
                    .font(.headline)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .padding()
            
            TabView(selection: $currentStep) {
                TaskWizardStepOne(formData: $formData)
                    .tag(0)
                TaskWizardStepTwo(formData: $formData)
                    .tag(1)
                TaskWizardStepThree(formData: $formData)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Button(currentStep == 2 ? "Create task" : "Next") {
                    if currentStep < 2 {
                        withAnimation {
                            currentStep += 1
                        }
                    } else {
                        createTask()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled((currentStep == 0 && !isStepOneValid) ||
                          (currentStep == 1 && !isStepTwoValid))
                .padding()
                
                HStack(spacing: 0) {
                    ForEach(0..<3) { index in
                            Circle()
                            .fill(currentStep == index ? Color.blue : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom)
            }
            
        }
    }
}

#Preview {
    AddTaskWizard()
}

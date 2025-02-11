//
//  TaskWizardStepTwo.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-11.
//

import SwiftUI

struct TaskWizardStepTwo: View {
    @Binding var formData: TaskFormData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Difficulty")
            
            HStack(spacing: 12) {
                ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                    Button {
                        formData.difficulty = difficulty
                    } label: {
                        Text(difficulty.rawValue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(formData.difficulty == difficulty ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(formData.difficulty == difficulty ? .white : .primary)
                            .cornerRadius(8)
                    }
                }
            }
            
            Toggle("Repeatable", isOn: $formData.isRepeatable)
                .padding(.vertical)
            
            Text("Mana")
            TextField("Mana", value: $formData.mana, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
        }
        .padding()
    }
}

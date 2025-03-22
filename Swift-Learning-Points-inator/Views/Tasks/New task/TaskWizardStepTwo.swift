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
            Text("Task Difficulty")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 5)

            
            // Difficulty selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Select Difficulty")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                // Reuse your existing DifficultyPickerView
                DifficultyPickerView(selectedDifficulty: $formData.difficulty, mana: $formData.mana)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color("card-background"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                    )
                    .tint(Color("accent-color"))
            }
            
            // Mana slider - without background
            VStack(alignment: .leading, spacing: 8) {
                Text("Mana Reward")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                // Reuse your existing ManaSliderView without the background
                ManaSliderView(mana: $formData.mana, difficulty: formData.difficulty)
                    .padding(.vertical, 12)
            }
        }
        .padding()
    }
}

//
//  TaskWizardStepThree.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-11.
//

import SwiftUI

struct TaskWizardStepThree: View {
    @Binding var formData: TaskFormData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Final Details")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("School of Magic")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                VStack {
                    SchoolPickerView(selectedSchool: $formData.school)
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
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                
                Toggle("Repeatable Task", isOn: $formData.isRepeatable)
                    .tint(Color("accent-color"))
            }
            Spacer()
        }
        .padding()
    }
}

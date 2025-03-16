//
//  TaskWizardStepOne.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-11.
//

import SwiftUI

struct TaskWizardStepOne: View {
    @Binding var formData: TaskFormData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Task Details")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Task Name")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                TextField("Enter task name", text: $formData.title)
                    .padding()
                    .background(Color("card-background"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                    )
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Description (Optional)")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                TextField("Enter task description", text: $formData.description)
                    .padding()
                    .frame(height: 100, alignment: .topLeading)
                    .background(Color("card-background"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                    )
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
    }
}

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
            VStack(alignment: .leading) {
                Text("Title:")
                TextField("Title", text: $formData.title)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack(alignment: .leading) {
                Text("Description")
                TextField("Description", text: $formData.description)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
    }
}

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
            Text("Select School")
            
            Picker("School", selection: $formData.school) {
                ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                    HStack {
                        Image(systemName: school.icon)
                        Text(school.rawValue)
                    }
                    .tag(school)
                }
            }
            
            Rectangle()
                .fill(.gray.opacity(0.1))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        }
        .padding()
    }
}

#Preview {
    TaskWizardStepThree()
}

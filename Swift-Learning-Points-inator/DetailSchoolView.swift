//
//  DetailSchoolView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-21.
//

import SwiftUI

struct DetailSchoolView: View {
    let school: SchoolOfMagic
    var body: some View {
        VStack(spacing: 20) {
            // Header section
            Image(systemName: school.icon)
                .font(.system(size: 60))
                .foregroundColor(.blue)  // Or any color you prefer
            
            Text(school.rawValue)
                .font(.title)
                .bold()
            
            // Description section
            VStack(alignment: .leading, spacing: 10) {
                Text("Description")
                    .font(.headline)
                
                Text(school.description)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
        .navigationTitle(school.rawValue)
    }
}
#Preview {
    NavigationStack {
        DetailSchoolView(school: .dataSorcery)
    }
}

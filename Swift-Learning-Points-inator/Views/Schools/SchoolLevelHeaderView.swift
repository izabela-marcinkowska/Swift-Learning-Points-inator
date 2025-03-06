//
//  SchoolLevelHeaderView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-05.
//

import SwiftUI

struct SchoolLevelHeaderView: View {
    let school: SchoolOfMagic
    
    var body: some View {
        VStack (spacing: 16) {
            Image(school.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            Text(school.rawValue)
                .font(.title2.bold())
            
            Text(school.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
    }
}

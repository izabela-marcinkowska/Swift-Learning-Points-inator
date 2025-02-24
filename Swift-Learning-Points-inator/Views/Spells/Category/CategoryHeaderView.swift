//
//  CategoryHeaderView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-20.
//

import SwiftUI

struct CategoryHeaderView: View {
    let category: SpellCategory
    
    var body: some View {
        VStack (spacing: 16) {
            Image(category.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            Text(category.rawValue)
                .font(.title2.bold())
            
            Text(category.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

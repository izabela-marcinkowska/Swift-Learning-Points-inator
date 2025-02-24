//
//  SpellGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-30.
//

import SwiftUI
import SwiftData

struct SpellCategoryGridItem: View {
    let category: SpellCategory
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(category.imageName)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 8) {
                Text(category.rawValue)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 8)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("card-background"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    SpellCategoryGridItem(category: .steadyPractice)
}

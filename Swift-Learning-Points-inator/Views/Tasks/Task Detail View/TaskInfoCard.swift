//
//  TaskInfoCard.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-26.
//

import SwiftUI

struct TaskInfoCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            content
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("card-background"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

//
//  TaskCategoryGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-07.
//

import SwiftUI

struct TaskCategoryGridItem: View {
    let title: String
    let icon: String
    let count: Int
    
    var body: some View {
        NavigationLink(destination: TaskCategoryDetailView(title: title)) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
                
                Text("\(count) tasks")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .frame(height: 120)
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

struct TaskCategoryGridItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryGridItem(
            title: "Data Sorcery",
            icon: "wand.and.rays",
            count: 5
        )
        .frame(width: 170)
        .padding()
    }
}

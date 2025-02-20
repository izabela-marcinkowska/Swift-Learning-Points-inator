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
    let tasks: [Task]
    var imageName: String? = nil
    
    var body: some View {
        NavigationLink(destination: TaskCategoryDetailView(title: title, tasks: tasks)) {
            HStack (spacing: 0) {
                VStack (alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Text("\(count) tasks")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.55, alignment: .leading)
                
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(22)
                        .frame(maxWidth: .infinity)
                } else {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .padding(22)
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(height: 120)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("card-background"),
                        Color("card-background").opacity(0.9),
                        Color.black
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TaskCategoryGridItem(
        title: "Data Sorcery",
        icon: "wand.and.rays",
        count: 2,
        tasks: [  // Add sample tasks for preview
            Task(name: "Learn SwiftData", mana: 60),
            Task(name: "Practice Queries", mana: 40)
        ]
    )
    .frame(width: 170)
    .padding()
}

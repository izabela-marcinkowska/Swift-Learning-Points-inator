//
//  DashboardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-27.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    var body: some View {
        NavigationStack {
            Rectangle()
                .fill(.gray.opacity(0.1))
                .frame(height: 200)
            VStack(spacing: 20) {
                HStack (spacing: 20) {
                    Text("Welcome, \(user?.name ?? "Apprentice")")
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                AffirmationWindow()
                Spacer()
                
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: User.self, inMemory: true)
}

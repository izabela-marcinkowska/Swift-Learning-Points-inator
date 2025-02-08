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
            VStack(spacing: 20) {
                if let user = user {
                    Text("Welcome, \(user.name)")
                        .font(.title)
                } else {
                    Text("Welcome, Apprentice")
                        .font(.title)
                }
                AffirmationWindow()
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: User.self, inMemory: true)
}

//
//  UserView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-09.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Query private var users: [User]
    
    private var user: User? {
            users.first
        }
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("User name: \(user?.name ?? "Unknown")")
                Text("Points: \(user?.points ?? 0)")
                Text("Streak: \(user?.streak ?? 0)")
            }
            .padding()
        }
        .navigationTitle("Welcome, \(user?.name ?? "User")")
    }
}

#Preview {
    UserView()
        .modelContainer(for: User.self, inMemory: true)
}

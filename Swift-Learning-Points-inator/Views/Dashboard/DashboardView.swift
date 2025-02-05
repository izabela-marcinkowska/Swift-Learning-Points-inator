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
    @Environment(\.modelContext) private var modelContext
    
    @Query private var affirmationsManagers: [AffirmationManager]
    @State private var currentAffirmation: Affirmation?
    private var affirmationManager: AffirmationManager? { affirmationsManagers.first }
    
    private func fetchDailyAffirmation() {
        guard let manager = affirmationManager else { return }
        
        do {
            currentAffirmation = try manager.getRandomAffirmation(context: modelContext)
        } catch {
            print("Error fetching affirmation: {\(error)")
        }
    }
    
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
                
                if let affirmation = currentAffirmation {
                    Text(affirmation.text)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
            .onAppear {
                fetchDailyAffirmation()
            }
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: User.self, inMemory: true)
}

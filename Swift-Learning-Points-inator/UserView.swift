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
    @Environment(\.modelContext) private var modelContext
    private var user: User? { users.first }
    @State private var showAlert: Bool = false
    @State private var newName = ""
    
    func submit () {
        if let user = user {
            user.name = newName
            try? modelContext.save()
        }
        newName = ""
    }
    
    var body: some View {
        VStack(spacing: 30) {  // Bigger spacing between main elements
            // Profile section
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            // Stats section
            VStack(spacing: 15) {  // Group stats together with less spacing
                HStack {
                    Image(systemName: "person.text.rectangle")
                    Text("Name: \(user?.name ?? "User")")
                }
                
                HStack {
                    Image(systemName: "star.fill")
                    Text("Points: \(user?.mana ?? 0)")
                }
                
                HStack {
                    Image(systemName: "flame.fill")
                    Text("Streak: \(user?.streak ?? 0)")
                }
            }
            
            VStack {
                Text("Interface Enchantments Progress:")
                    .font(.headline)
                ProgressView(value: 0.6)
                    .tint(.blue)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Welcome, \(user?.name ?? "User")")
        .toolbar {
            ToolbarItem {
                Button {
                    showAlert.toggle()
                } label: {
                    Image(systemName: "pencil")
                }
                .alert("Enter your name", isPresented: $showAlert) {
                    TextField("Name", text: $newName)
                    Button("Cancel", role: .cancel) {}
                    Button("OK", action: submit)
                } message: {
                    Text("Please enter your name")
                }
            }
        }
    }
}

#Preview {
    UserView()
        .modelContainer(for: User.self, inMemory: true)
}

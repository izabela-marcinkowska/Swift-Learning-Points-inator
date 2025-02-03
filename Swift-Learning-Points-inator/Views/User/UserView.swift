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
    private var user: User? { users.first }
    @Environment(\.modelContext) private var modelContext
    @State private var showAlert: Bool = false
    @State private var newName = ""
    
    private func submit () {
        if let user = user {
            user.name = newName
            try? modelContext.save()
        }
        newName = ""
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                VStack(spacing: 15) {
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
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
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

#Preview {
    UserView()
        .modelContainer(for: User.self, inMemory: true)
}

//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

extension ThemePreference {
    var colorScheme: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}

struct ContentView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    var body: some View {
        
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            SpellBookView()
                .tabItem {
                    Label("Spellbook", systemImage: "book.fill")
                }
            
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "list.bullet")
                }
            
            SchoolsView()
                .tabItem {
                    Label("Schools", systemImage: "books.vertical.fill")
                }
            
            UserView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .preferredColorScheme({
            if let user = user {
                // If user exists and chose system, return nil (i.e. system default)
                // Otherwise, return the forced color scheme.
                return user.themePreference == .system ? nil : user.themePreference.colorScheme
            } else {
                // If no user, default to Light Mode.
                return .light
            }
        }())
        .onAppear {
                print("DEBUG: user's themePreference is \(String(describing: user?.themePreference))")
            }
    }
}

#Preview {
    ContentView()
}

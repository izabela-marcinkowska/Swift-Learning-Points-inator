//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    var body: some View {
        
        TabView {
            DashboardView()
                .tabItem {
                    VStack {
                        ScaledImage(name: "dashboard", size: CGSize(width: 32, height: 32))
                        Text("Dashboard")
                    }
                }
            
            SpellBookView()
                .tabItem {
                    VStack {
                        ScaledImage(name: "magic-book", size: CGSize(width: 32, height: 32))
                        Text("Spellbook")
                    }
                }
            
            TasksView()
                .tabItem {
                    ScaledImage(name: "tasks-icon", size: CGSize(width: 32, height: 32))
                    Text("Tasks")
                }
            
            SchoolsView()
                .tabItem {
                    ScaledImage(name: "schools", size: CGSize(width: 32, height: 32))
                    Text("Schools")
                }
            
            UserView()
                .tabItem {
                    ScaledImage(name: "profile", size: CGSize(width: 32, height: 32))
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}

struct ScaledImage: View {
    let name: String
    let size: CGSize
    
    var body: Image {
        let uiImage = resizedImage(named: self.name, for: self.size) ?? UIImage()
        
        return Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
    }
    
    func resizedImage(named: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

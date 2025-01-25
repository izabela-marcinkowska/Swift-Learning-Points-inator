//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            Text("Hello")
        
        .navigationTitle("Welcome, User")
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                NavigationLink {
                    UserView()
                } label: {
                    Image(systemName: "person")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    SchoolsView()
                } label: {
                    Image(systemName: "flag.2.crossed")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    TasksView()
                } label: {
                    Image(systemName: "list.bullet")
                }
            }
        }
    }
    }
}

#Preview {
ContentView()
}

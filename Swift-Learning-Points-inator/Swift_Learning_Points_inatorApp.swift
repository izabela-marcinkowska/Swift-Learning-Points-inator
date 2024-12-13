//
//  Swift_Learning_Points_inatorApp.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

@main
struct Swift_Learning_Points_inatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self, Task.self])
        }
    }
}

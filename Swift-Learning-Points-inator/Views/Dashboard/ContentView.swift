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
    
    // Both managers are injected via EnvironmentObject
    @EnvironmentObject private var taskNotificationManager: TaskNotificationManager
    @EnvironmentObject private var toastManager: ToastManager

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
        .magicalToast(using: toastManager)
        .onChange(of: taskNotificationManager.shouldShowToast) { oldValue, newValue in
            if newValue {
                if let task = taskNotificationManager.createdTask {
                    toastManager.showTaskCreated(task: task)
                } else if let task = taskNotificationManager.updatedTask {
                    toastManager.showTaskUpdated(task: task)
                } else if let name = taskNotificationManager.deletedTaskName,
                          let school = taskNotificationManager.deletedTaskSchool {
                    toastManager.showTaskDeleted(name: name, school: school)
                } else if let task = taskNotificationManager.completedTask {
                    toastManager.showTaskCompletion(task: task, mana: taskNotificationManager.completedTaskMana)
                } else if let school = taskNotificationManager.levelUpSchool,
                          let level = taskNotificationManager.levelUpLevel {
                    toastManager.showLevelUp(school: school, level: level)
                }
                taskNotificationManager.clearTaskData()
            }
        }
    }
}

struct ScaledImage: View {
    let name: String
    let size: CGSize
    
    var body: some View {
        let uiImage = resizedImage(named: self.name, for: self.size) ?? UIImage()
        return Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
    }
    
    func resizedImage(named: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

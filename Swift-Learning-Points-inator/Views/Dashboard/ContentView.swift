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
    @EnvironmentObject private var taskDeletionManager: TaskDeletionManager
        @StateObject private var toastManager = ToastManager()
    @State private var showTestToast = false
    
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
        .onChange(of: taskDeletionManager.shouldShowToast) { oldValue, newValue in
            if newValue == true {
                if let name = taskDeletionManager.deletedTaskName,
                   let school = taskDeletionManager.deletedTaskSchool {
                    print("ContentView showing toast for: \(name)")
                    toastManager.showTaskDeleted(name: name, school: school)
                    taskDeletionManager.clearDeletedTask()
                }
            }
        }
        .onChange(of: taskDeletionManager.createdTask) { oldValue, newValue in
            if let task = newValue {
                print("ContentView showing toast for created task: \(task.name)")
                toastManager.showTaskCreated(task: task)
                taskDeletionManager.clearCreatedTask()
            }
        }
        .onChange(of: taskDeletionManager.hasCompletedTask) { oldValue, newValue in
            if newValue,
               let task = taskDeletionManager.completedTask {
                print("ContentView showing toast for completed task: \(task.name)")
                toastManager.showTaskCompletion(task: task, mana: taskDeletionManager.completedTaskMana)
                taskDeletionManager.clearCompletedTask()
            }
        }

        .onChange(of: taskDeletionManager.hasLevelUp) { oldValue, newValue in
            if newValue,
               let school = taskDeletionManager.levelUpSchool,
               let level = taskDeletionManager.levelUpLevel {
                print("ContentView showing toast for level up: \(school.rawValue)")
                toastManager.showLevelUp(school: school, level: level)
                taskDeletionManager.clearTaskLevelUp()
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

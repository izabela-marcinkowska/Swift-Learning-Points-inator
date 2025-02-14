//
//  TaskResetManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-14.
//

import Foundation
import SwiftData

class TaskResetManager {
    static let shared = TaskResetManager()
    private init() {}
    
    private let lastResetDateKey = "lastTaskResetDate"
    private let resetHour = 3
    
    /// Returns the last date when tasks were reset
    private var lastResetDate: Date? {
        get {
            UserDefaults.standard.object(forKey: lastResetDateKey) as? Date
        } set {
            UserDefaults.standard.set(newValue, forKey: lastResetDateKey)
        }
    }
    
    /// Checks if tasks need to be reset by comparing current time with last reset time
    private func needReset() -> Bool {
        guard let lastReset = lastResetDate else {
            // If we never reset before
            return true
        }
        
        let calendar = Calendar.current
        
        // Get the next reset date (3 AM after the last reset)
        guard let nextResetDate = calendar.date(
            bySettingHour: resetHour, minute: 0, second: 0, of: calendar.date(byAdding: .day, value: 1, to: lastReset) ?? Date()
        ) else {
            return false
        }
        return Date() >= nextResetDate
    }
    
    private func performReset(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<Task>(
            predicate: #Predicate<Task> { task in
                task.isRepeatable
            }
        )
        
        do {
            let repeatableTasks = try modelContext.fetch(descriptor)
            
            for task in repeatableTasks {
                task.isCompleted = false
                task.currentCompletionDate = nil
            }
            
            try modelContext.save()
            
            lastResetDate = Date()
        } catch {
            print("Error resetting tasks: \(error)")
        }
    }
    
    func checkAndResetTasks(modelContext: ModelContext) {
        if needReset() {
            performReset(modelContext: modelContext)
        }
    }
    
}

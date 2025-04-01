//
//  TaskNotificationManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-01.
//

import Foundation
import SwiftUI
import Combine

enum TaskActionType {
    case created
    case updated
    case deleted
    case completed
    // We remove levelUp from here since it needs extra data.
}

class TaskNotificationManager: ObservableObject {
    // State for task events
    @Published var deletedTaskName: String?
    @Published var deletedTaskSchool: SchoolOfMagic?
    
    @Published var createdTask: Task?
    
    @Published var completedTask: Task?
    @Published var completedTaskMana: Int = 0
    
    // Level-up state now holds the school and the exact level achieved.
    @Published var levelUpSchool: SchoolOfMagic?
    @Published var levelUpLevel: SchoolOfMagic.AchievementLevel?
    
    @Published var updatedTask: Task?
    
    // A flag that signals that a toast should be shown.
    @Published var shouldShowToast = false

    // Reference to ToastManager (only used to trigger UI display).
    private var toastManager: ToastManager?
    
    // Call this from your App initialization to inject the ToastManager.
    func setToastManager(manager: ToastManager) {
        self.toastManager = manager
    }
    
    // Report task actions (created, updated, deleted, completed).
    // These methods update the relevant state and trigger the corresponding toast.
    func reportTaskAction(type: TaskActionType, task: Task, mana: Int? = nil) {
            switch type {
            case .created:
                createdTask = task
            case .updated:
                updatedTask = task  // Just update the state; don't call toastManager directly.
            case .deleted:
                deletedTaskName = task.name
                deletedTaskSchool = task.school
            case .completed:
                completedTask = task
                completedTaskMana = mana ?? 0
            }
            shouldShowToast = true
        }

    
    // Report a level-up action.
    // Instead of assuming a default level, you must pass in the school and the new level.
    func reportTaskLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        levelUpSchool = school
        levelUpLevel = level
        shouldShowToast = true
    }
    
    // Clear all task-related state after the toast is dismissed.
    func clearTaskData() {
        deletedTaskName = nil
        updatedTask = nil
        deletedTaskSchool = nil
        createdTask = nil
        completedTask = nil
        completedTaskMana = 0
        levelUpSchool = nil
        levelUpLevel = nil
        shouldShowToast = false
    }
}

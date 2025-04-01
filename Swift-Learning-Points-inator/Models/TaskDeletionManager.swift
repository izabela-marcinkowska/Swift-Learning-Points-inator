//
//  TaskDeletionManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-01.
//

import Foundation
import SwiftUI
import Combine

class TaskDeletionManager: ObservableObject {
    // For deletion
    @Published var deletedTaskName: String?
    @Published var deletedTaskSchool: SchoolOfMagic?
    @Published var shouldShowToast = false
    
    // For creation
    @Published var createdTask: Task?
    
    // For completion - replace tuple with separate properties
    @Published var completedTask: Task?
    @Published var completedTaskMana: Int = 0
    @Published var hasCompletedTask = false
    
    // For level up - replace tuple with separate properties
    @Published var levelUpSchool: SchoolOfMagic?
    @Published var levelUpLevel: SchoolOfMagic.AchievementLevel?
    @Published var hasLevelUp = false
    
    func reportTaskDeleted(name: String, school: SchoolOfMagic) {
        deletedTaskName = name
        deletedTaskSchool = school
        shouldShowToast = true
    }
    
    func clearDeletedTask() {
        deletedTaskName = nil
        deletedTaskSchool = nil
        shouldShowToast = false
    }
    
    func reportTaskCreated(task: Task) {
        createdTask = task
    }
    
    func clearCreatedTask() {
        createdTask = nil
    }
    
    func reportTaskCompleted(task: Task, mana: Int) {
        completedTask = task
        completedTaskMana = mana
        hasCompletedTask = true
    }
    
    func clearCompletedTask() {
        completedTask = nil
        completedTaskMana = 0
        hasCompletedTask = false
    }
    
    func reportTaskLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        levelUpSchool = school
        levelUpLevel = level
        hasLevelUp = true
    }
    
    func clearTaskLevelUp() {
        levelUpSchool = nil
        levelUpLevel = nil
        hasLevelUp = false
    }
}

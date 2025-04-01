//
//  TaskNotificationManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-01.
//

import Foundation
import SwiftUI
import Combine

enum NotificationType {
    case taskCreated
    case taskUpdated
    case taskDeleted
    case taskCompleted
    case levelUp
    case spellLevelUp
    case manaInvested
    // We remove levelUp from here since it needs extra data.
}

class TaskNotificationManager: ObservableObject {
    @Published var deletedTaskName: String?
    @Published var deletedTaskSchool: SchoolOfMagic?
    
    @Published var createdTask: Task?
    
    @Published var completedTask: Task?
    @Published var completedTaskMana: Int = 0
    
    @Published var levelUpSchool: SchoolOfMagic?
    @Published var levelUpLevel: SchoolOfMagic.AchievementLevel?
    
    @Published var updatedTask: Task?
    
    // Add new spell-related properties
    @Published var spellLevelUp: (spell: Spell, level: SpellLevel)?
    @Published var manaInvested: (spell: Spell, amount: Int)?
    
    // Flag that signals a toast should be shown
    @Published var shouldShowToast = false
    @Published var notificationType: NotificationType?
    
    // Reference to ToastManager
    private var toastManager: ToastManager?
    
    func setToastManager(manager: ToastManager) {
        self.toastManager = manager
    }
    
    private var delayedLevelUpInfo: (school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel)?
    
    // Report task actions (created, updated, deleted, completed).
    // These methods update the relevant state and trigger the corresponding toast.
    func reportTaskAction(type: NotificationType, task: Task, mana: Int? = nil) {
        switch type {
        case .taskCreated:
            createdTask = task
        case .taskUpdated:
            updatedTask = task
        case .taskDeleted:
            deletedTaskName = task.name
            deletedTaskSchool = task.school
        case .taskCompleted:
            completedTask = task
            completedTaskMana = mana ?? 0
        case .levelUp, .spellLevelUp, .manaInvested:
            // These are handled by other methods
            break
        }
        notificationType = type
        shouldShowToast = true
    }

    
    // Report a level-up action.
    // Instead of assuming a default level, you must pass in the school and the new level.
    func reportTaskLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        levelUpSchool = school
        levelUpLevel = level
        shouldShowToast = true
    }
    
    func reportSpellLevelUp(spell: Spell, level: SpellLevel) {
        spellLevelUp = (spell: spell, level: level)
        notificationType = .spellLevelUp
        shouldShowToast = true
    }
    
    func reportManaInvested(spell: Spell, amount: Int) {
        manaInvested = (spell: spell, amount: amount)
        notificationType = .manaInvested
        shouldShowToast = true
    }
    
    func reportTaskCompletedWithLevelUp(task: Task, mana: Int, school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        // First show task completion
        completedTask = task
        completedTaskMana = mana
        notificationType = .taskCompleted
        shouldShowToast = true
        
        // Store level up info for delayed notification
        delayedLevelUpInfo = (school, level)
        
        // Set a timer to show level up notification after the first toast
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
            guard let self = self, let levelUpInfo = self.delayedLevelUpInfo else { return }
            
            self.levelUpSchool = levelUpInfo.school
            self.levelUpLevel = levelUpInfo.level
            self.notificationType = .levelUp
            self.shouldShowToast = true
            self.delayedLevelUpInfo = nil
        }
    }
    
    // Clear all task-related state after the toast is dismissed.
    func clearToastData() {
        // Clear task-related data
        deletedTaskName = nil
        updatedTask = nil
        deletedTaskSchool = nil
        createdTask = nil
        completedTask = nil
        completedTaskMana = 0
        levelUpSchool = nil
        levelUpLevel = nil
        
        // Clear spell-related data
        spellLevelUp = nil
        manaInvested = nil
        
        notificationType = nil
        shouldShowToast = false
    }
}

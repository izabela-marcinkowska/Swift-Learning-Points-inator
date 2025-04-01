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
}

/// Manages notification state and coordinates with ToastManager to display
/// user-facing notifications about task, school, and spell-related events.
///
/// This class tracks notification data and determines when notifications should
/// be shown to the user. It works with the ToastManager to handle the visual
/// presentation of these notifications.
class TaskNotificationManager: ObservableObject {
    @Published var deletedTaskName: String?
    @Published var deletedTaskSchool: SchoolOfMagic?
    
    @Published var createdTask: Task?
    
    @Published var completedTask: Task?
    @Published var completedTaskMana: Int = 0
    
    @Published var levelUpSchool: SchoolOfMagic?
    @Published var levelUpLevel: SchoolOfMagic.AchievementLevel?
    
    @Published var updatedTask: Task?
    
    @Published var spellLevelUp: (spell: Spell, level: SpellLevel)?
    @Published var manaInvested: (spell: Spell, amount: Int)?
    
    @Published var shouldShowToast = false
    @Published var notificationType: NotificationType?
    
    private var toastManager: ToastManager?
    
    /// Sets the ToastManager instance that will be used to display notifications
    /// - Parameter manager: The ToastManager instance to use
    func setToastManager(manager: ToastManager) {
        self.toastManager = manager
    }
    
    /// Temporarily stores level up information for delayed notifications
    /// Used when we want to show a level-up notification after a task completion
    private var delayedLevelUpInfo: (school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel)?
    
    /// Reports a task-related action that should trigger a notification
    ///
    /// - Parameters:
    ///   - type: The type of notification to display
    ///   - task: The task associated with the notification
    ///   - mana: Optional mana amount for task completion notifications
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
            break
        }
        notificationType = type
        shouldShowToast = true
    }


    /// Reports a school level up achievement that should trigger a notification
    ///
    /// - Parameters:
    ///   - school: The school that leveled up
    ///   - level: The new achievement level reached
    func reportTaskLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        levelUpSchool = school
        levelUpLevel = level
        shouldShowToast = true
    }
    
    /// Reports a spell level up that should trigger a notification
    ///
    /// - Parameters:
    ///   - spell: The spell that leveled up
    ///   - level: The new spell level reached
    func reportSpellLevelUp(spell: Spell, level: SpellLevel) {
        spellLevelUp = (spell: spell, level: level)
        notificationType = .spellLevelUp
        shouldShowToast = true
    }
    
    /// Reports that mana was invested in a spell
    ///
    /// - Parameters:
    ///   - spell: The spell that received the mana investment
    ///   - amount: Amount of mana invested
    func reportManaInvested(spell: Spell, amount: Int) {
        manaInvested = (spell: spell, amount: amount)
        notificationType = .manaInvested
        shouldShowToast = true
    }
    
    /// Reports a task completion that also triggered a level up
    /// Shows the task completion notification first, followed by a delayed
    /// level up notification.
    ///
    /// - Parameters:
    ///   - task: The completed task
    ///   - mana: Amount of mana earned from the task
    ///   - school: The school that leveled up
    ///   - level: The new achievement level reached
    func reportTaskCompletedWithLevelUp(task: Task, mana: Int, school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        completedTask = task
        completedTaskMana = mana
        notificationType = .taskCompleted
        shouldShowToast = true
        
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
    
    /// Clears all notification-related data after a toast is dismissed
    /// Resets all published properties to their default state
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

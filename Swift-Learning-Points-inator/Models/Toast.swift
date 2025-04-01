//
//  Toast.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-30.
//

import Foundation
import SwiftUI
import Combine

/// Represents a toast notification message to be displayed to the user.
/// Contains all information needed to render the toast, including text content and icons.
struct ToastMessage: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let message: String
    let icon: IconType
    
    enum IconType: Equatable {
        case spellLevel(level: SpellLevel)
        case schoolIcon(school: SchoolOfMagic)
        case image(name: String)
    }
}

/// Manages the display of toast notifications in the app.
///
/// Handles creating toast messages, timing their display duration,
/// and dismissing them automatically. Provides convenience methods
/// for showing different types of toast notifications.
class ToastManager: ObservableObject {
    @Published var currentToast: ToastMessage?
    private var cancellable: AnyCancellable?
    
    /// Shows a toast notification with the specified content
    ///
    /// - Parameters:
    ///   - title: The title text for the toast
    ///   - message: The body message for the toast
    ///   - icon: The icon to display in the toast
    ///   - duration: How long the toast should remain visible (in seconds)
    private func show(title: String, message: String, icon: ToastMessage.IconType, duration: Double = 3.0) {
        cancellable?.cancel()
        
        let toast = ToastMessage(title: title, message: message, icon: icon)
        withAnimation(.spring()) {
            currentToast = toast
        }
        
        cancellable = Just(())
            .delay(for: .seconds(duration), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                withAnimation(.easeOut) {
                    self?.currentToast = nil
                }
            }
    }
    
    /// Manually dismisses the current toast notification, if any
    func hide() {
        cancellable?.cancel()
        withAnimation(.easeOut) {
            currentToast = nil
        }
    }
    
    /// Shows a toast notification for a school level-up achievement
    ///
    /// - Parameters:
    ///   - school: The school that leveled up
    ///   - level: The new achievement level
    func showLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        show(
            title: "Level up",
            message: "You've reached \(school.titleForLevel(level)) in \(school.rawValue)!",
            icon: .schoolIcon(school: school),
            duration: 4.0
        )
    }
    
    /// Shows a toast notification for a spell level-up
    ///
    /// - Parameters:
    ///   - spell: The spell that leveled up
    ///   - level: The new spell level
    func showSpellLevelUp(spell: Spell, level: SpellLevel) {
        show(
            title: "Spell Level Up",
            message: "\(spell.name) had reached \(level.title)",
            icon: .spellLevel(level: level),
            duration: 4.0
        )
    }
    
    /// Shows a toast notification for a completed task
    ///
    /// - Parameters:
    ///   - task: The completed task
    ///   - mana: Amount of mana earned from the task
    func showTaskCompletion(task: Task, mana: Int) {
        show(
            title: "Task Completed",
            message: "You've earned \(mana) mana for completing \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    /// Shows a toast notification for mana invested in a spell
    ///
    /// - Parameters:
    ///   - spell: The spell that received the mana investment
    ///   - amount: Amount of mana invested
    func showManaInvested(spell: Spell, amount: Int) {
        show(
            title: "Mana Invested!",
            message: "You've invested \(amount) mana in \(spell.name).",
            icon: .image(name: spell.imageName),
            duration: 3.0
        )
    }
    
    /// Shows a toast notification for a newly created task
    ///
    /// - Parameter task: The newly created task
    func showTaskCreated(task: Task) {
        show(
            title: "Task Created",
            message: "You've created a new task: \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    /// Shows a toast notification for an updated task
    ///
    /// - Parameter task: The updated task
    func showTaskUpdated(task: Task) {
        show(
            title: "Task Updated",
            message: "You've updated the task: \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    /// Shows a toast notification for a deleted task
    ///
    /// - Parameters:
    ///   - name: The name of the deleted task
    ///   - school: The school of the deleted task
    func showTaskDeleted(name: String, school: SchoolOfMagic) {
        print("Showing delete toast for: \(name)")
        show(
            title: "Task Deleted",
            message: "\(name) has been deleted.",
            icon: .schoolIcon(school: school),
            duration: 3.0
        )
    }
    
}

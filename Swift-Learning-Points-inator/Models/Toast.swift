//
//  Toast.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-30.
//

import Foundation
import SwiftUI
import Combine

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

class ToastManager: ObservableObject {
    @Published var currentToast: ToastMessage?
    private var cancellable: AnyCancellable?
    
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
    
    func hide() {
        cancellable?.cancel()
        withAnimation(.easeOut) {
            currentToast = nil
        }
    }
    
    // for level up
    func showLevelUp(school: SchoolOfMagic, level: SchoolOfMagic.AchievementLevel) {
        show(
            title: "Level up",
            message: "You've reached \(school.titleForLevel(level)) in \(school.rawValue)!",
            icon: .schoolIcon(school: school),
            duration: 4.0
        )
    }
    
    // for spell level up
    func showSpellLevelUp(spell: Spell, level: SpellLevel) {
        show(
            title: "Spell Level Up",
            message: "\(spell.name) had reached \(level.title)",
            icon: .spellLevel(level: level),
            duration: 4.0
        )
    }
    
    // for task completion
    func showTaskCompletion(task: Task, mana: Int) {
        show(
            title: "Task Completed",
            message: "You've earned \(mana) mana for completing \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    // for mana investment
    func showManaInvested(spell: Spell, amount: Int) {
        show(
            title: "Mana Invested!",
            message: "You've invested \(amount) mana in \(spell.name).",
            icon: .image(name: spell.imageName),
            duration: 3.0
        )
    }
    
    // for new task
    func showTaskCreated(task: Task) {
        show(
            title: "Task Created",
            message: "You've created a new task: \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    // for edit task
    func showTaskUpdated(task: Task) {
        show(
            title: "Task Updated",
            message: "You've updated the task: \(task.name).",
            icon: .schoolIcon(school: task.school),
            duration: 3.0
        )
    }
    
    // for delete task
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

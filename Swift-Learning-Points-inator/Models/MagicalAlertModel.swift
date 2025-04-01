//
//  MagicalAlertModel.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-23.
//

import Foundation

/// Model for custom alert dialogs with magical theming.
/// Defines the content, appearance, and actions for alert dialogs displayed to the user.
struct MagicalAlertModel {
    enum AlertIcon {
        case systemIcon(name: String)
        case image(name: String)
        case spellLevel(level: SpellLevel)
        case schoolIcon(school: SchoolOfMagic)
    }
    
    var title: String
    var message: String
    var primaryButtonText: String
    var secondaryButtonText: String?
    var primaryAction: () -> Void
    var secondaryAction: (() -> Void)?
    var icon: AlertIcon?
    
    /// Creates a basic alert with a single action button
    ///
    /// - Parameters:
    ///   - title: The title text for the alert
    ///   - message: The body message for the alert
    ///   - buttonText: Text for the action button (defaults to "OK")
    ///   - action: Action to perform when the button is tapped
    /// - Returns: A configured MagicalAlertModel
    static func basic(
        title: String,
        message: String,
        buttonText: String = "OK",
        action: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: title,
            message: message,
            primaryButtonText: buttonText,
            secondaryButtonText: nil,
            primaryAction: action,
            secondaryAction: nil
        )
    }
    
    /// Creates a confirmation alert with confirm and cancel buttons
    ///
    /// - Parameters:
    ///   - title: The title text for the alert
    ///   - message: The body message for the alert
    ///   - confirmText: Text for the confirmation button (defaults to "Confirm")
    ///   - cancelText: Text for the cancel button (defaults to "Cancel")
    ///   - onConfirm: Action to perform when the confirm button is tapped
    ///   - onCancel: Action to perform when the cancel button is tapped
    /// - Returns: A configured MagicalAlertModel for confirmation
    static func confirmation(
        title: String,
        message: String,
        confirmText: String = "Confirm",
        cancelText: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: title,
            message: message,
            primaryButtonText: confirmText,
            secondaryButtonText: cancelText,
            primaryAction: onConfirm,
            secondaryAction: onCancel
        )
    }
    
    /// Creates an alert for a spell level-up achievement
    ///
    /// - Parameters:
    ///   - spellName: Name of the spell that leveled up
    ///   - level: The new spell level achieved
    ///   - buttonText: Text for the action button (defaults to "Amazing!")
    ///   - action: Action to perform when the button is tapped
    /// - Returns: A configured MagicalAlertModel for spell level-up
    static func levelUp(
        spellName: String,
        level: SpellLevel,
        buttonText: String = "Amazing!",
        action: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: "New Level Achieved!",
            message: "\(spellName) has now reached \(level.title)!",
            primaryButtonText: buttonText,
            secondaryButtonText: nil,
            primaryAction: action,
            secondaryAction: nil,
            icon: .spellLevel(level: level)
        )
    }
    
    /// Creates an alert for a school progress achievement
    ///
    /// - Parameters:
    ///   - school: The school that had a level achievement
    ///   - level: The new achievement level
    ///   - buttonText: Text for the action button (defaults to "Continue")
    ///   - action: Action to perform when the button is tapped
    /// - Returns: A configured MagicalAlertModel for school progress
    static func schoolProgress(
        school: SchoolOfMagic,
        level: SchoolOfMagic.AchievementLevel,
        buttonText: String = "Continue",
        action: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: "School Achievement!",
            message: "You have achieved \(school.titleForLevel(level)) in \(school.rawValue)!",
            primaryButtonText: buttonText,
            secondaryButtonText: nil,
            primaryAction: action,
            secondaryAction: nil,
            icon: .schoolIcon(school: school)
        )
    }
    
}

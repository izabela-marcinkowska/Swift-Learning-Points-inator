//
//  MagicalAlertModel.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-23.
//

import Foundation

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
    
    static func confirmation(
        title: String,
        message: String,
        confirmText: String = "Bekräfta",
        cancelText: String = "Avbryt",
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
    
    static func levelUp(
        spellName: String,
        level: SpellLevel,
        buttonText: String = "Fantastiskt!",
        action: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: "Ny nivå uppnådd!",
            message: "\(spellName) har nu nått \(level.title)!",
            primaryButtonText: buttonText,
            secondaryButtonText: nil,
            primaryAction: action,
            secondaryAction: nil,
            icon: .spellLevel(level: level)
        )
    }
    
    static func schoolProgress(
        school: SchoolOfMagic,
        level: SchoolOfMagic.AchievementLevel,
        buttonText: String = "Fortsätt",
        action: @escaping () -> Void = {}
    ) -> MagicalAlertModel {
        MagicalAlertModel(
            title: "Skolframgång!",
            message: "Du har uppnått \(school.titleForLevel(level)) i \(school.rawValue)!",
            primaryButtonText: buttonText,
            secondaryButtonText: nil,
            primaryAction: action,
            secondaryAction: nil,
            icon: .schoolIcon(school: school)
        )
    }
    
}

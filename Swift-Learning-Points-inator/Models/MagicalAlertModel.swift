//
//  MagicalAlertModel.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-23.
//

import Foundation

struct MagicalAlertModel {
    var title: String
    var message: String
    var primaryButtonText: String
    var secondaryButtonText: String?
    var primaryAction: () -> Void
    var secondaryAction: (() -> Void)?
    var icon: String?
    
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
    
}

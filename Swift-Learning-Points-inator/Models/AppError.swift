//
//  AppError.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-11.
//

import Foundation

enum AppError: Error {
    case dataModification(String)
    case taskOperation(String)
    case spellOperation(String)
    case dataFetch(String)
    case generalError(String)
    
    var userMessage: String {
        switch self {
        case .dataModification(let message):
            return "Couldn't save your changes: \(message)"
        case .taskOperation(let message):
            return "Task operation failed: \(message)"
        case .spellOperation(let message):
            return "Spell operation failed: \(message)"
        case .dataFetch(let message):
            return "Couldn't retrieve data: \(message)"
        case .generalError(let message):
            return "Something went wrong: \(message)"
        }
    }
    
    var icon: ToastMessage.IconType {
        switch self {
        case .taskOperation:
            return .image(name: "tasks-icon")
        case .spellOperation:
            return .image(name: "magic-book")
        default:
            return .image(name: "error-icon")
        }
    }
    
}

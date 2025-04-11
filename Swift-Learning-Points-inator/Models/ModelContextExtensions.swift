//
//  ModelContextExtensions.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-11.
//

import Foundation
import SwiftUI
import SwiftData

extension ModelContext {
    /// Attempts to save the context and handles errors appropriately
    ///
    /// - Parameters:
    ///   - toastManager: The toast manager to show error notifications
    ///   - context: Description of the operation being performed
    /// - Returns: Whether the save operation succeeded
    func saveWithErrorHandling(toastManager: ToastManager, context: String) -> Bool {
        do {
            try save()
            return true
        } catch {
            toastManager.handleError(
                AppError.dataModification("Couldn't save changes."),
                context: context
            )
            return false
        }
    }
}

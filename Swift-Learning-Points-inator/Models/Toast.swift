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
    
    
    
}

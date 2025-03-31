//
//  ToastModifier.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-31.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @ObservedObject var toastManager: ToastManager
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            if let toast = toastManager.currentToast {
                MagicalToastView(toast: toast)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.height < -20 {
                                    toastManager.hide()
                                }
                            }
                    )
                    .padding(.top, 16)
            }
        }
    }
}

extension View {
    func magicalToast(using manager: ToastManager) -> some View {
        self.modifier(ToastModifier(toastManager: manager))
    }
}

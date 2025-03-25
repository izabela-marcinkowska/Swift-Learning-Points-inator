//
//  ButtonsShow.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-25.
//

import SwiftUI

struct ButtonsShow: View {
    @State private var showAlert: MagicalAlertModel? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Visa enkel alert") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showAlert = MagicalAlertModel.basic(
                        title: "Framgång!",
                        message: "Du har slutfört denna uppgift och tjänat 50 mana.",
                        buttonText: "Fortsätt"
                    )
                }
            }
            .buttonStyle(MagicalButtonStyle())
            
            Button("Visa bekräftelse-alert") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showAlert = MagicalAlertModel.confirmation(
                        title: "Slutför uppgift?",
                        message: "Vill du markera denna uppgift som slutförd? Du kommer att få 80 mana.",
                        confirmText: "Slutför",
                        cancelText: "Inte nu",
                        onConfirm: {
                            print("Uppgift slutförd!")
                        }
                    )
                }
            }
            .buttonStyle(MagicalButtonStyle())
            
            Button("Visa alert med systemikon") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    var alertModel = MagicalAlertModel.basic(
                        title: "Information",
                        message: "Detta är en alert med en systemikon.",
                        buttonText: "OK"
                    )
                    alertModel.icon = .systemIcon(name: "info.circle")
                    showAlert = alertModel
                }
            }
            .buttonStyle(MagicalButtonStyle())
            
            Button("Visa alert med spell level ikon") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showAlert = MagicalAlertModel.levelUp(
                        spellName: "Clarity Charm",
                        level: .expert,
                        action: {
                            print("Spell level alert closed")
                        }
                    )
                }
            }
            .buttonStyle(MagicalButtonStyle())
            
            Button("Visa alert med school ikon") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showAlert = MagicalAlertModel.schoolProgress(
                        school: .viewAlchemy,
                        level: .archmage,
                        action: {
                            print("School progress alert closed")
                        }
                    )
                }
            }
            .buttonStyle(MagicalButtonStyle())
        }
        .padding()
        .magicalAlert(isPresented: $showAlert)
    }
}


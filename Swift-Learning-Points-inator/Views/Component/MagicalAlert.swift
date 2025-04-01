//
//  MagicalAlert.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-25.
//

import SwiftUI

struct MagicalAlert: View {
    let model: MagicalAlertModel
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    if model.secondaryButtonText != nil {
                        model.secondaryAction?()
                        dismiss()
                    }
                }
            
            VStack(spacing: 20) {
                if let icon = model.icon {
                    switch icon {
                    case .systemIcon(let name):
                        Image(systemName: name)
                            .font(.system(size: 32))
                            .foregroundColor(Color("progress-color"))
                            .padding(.top, 8)
                    case .image(let name):
                        Image(name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .padding(.top, 8)
                    case .spellLevel(let level):
                        Image(level.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .padding(.top, 8)
                    case .schoolIcon(let school):
                        Image(school.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .padding(.top, 8)
                    }
                }
                
                Text(model.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Text(model.message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 16) {
                    if let secondaryText = model.secondaryButtonText {
                        Button {
                            model.secondaryAction?()
                            dismiss()
                        } label: {
                            Text(secondaryText)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(SecondaryAlertButtonStyle())
                    }
                    
                    Button {
                        model.primaryAction()
                        dismiss()
                    } label: {
                        Text(model.primaryButtonText)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryAlertButtonStyle())
                }
            }
            .padding(24)
            .background(Color("card-background"))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.purple.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
            .padding(.horizontal, 40)
            .transition(.scale.combined(with: .opacity))
        }
    }
}


struct PrimaryAlertButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("button-color").opacity(0.7), Color("button-color")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SecondaryAlertButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(Color.primary)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MagicalAlertModifier: ViewModifier {
    @Binding var alert: MagicalAlertModel?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let alert = alert {
                MagicalAlert(model: alert) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.alert = nil
                    }
                }
                .zIndex(100)
            }
        }
    }
}

extension View {
    func magicalAlert(isPresented: Binding<MagicalAlertModel?>) -> some View {
        self.modifier(MagicalAlertModifier(alert: isPresented))
    }
}

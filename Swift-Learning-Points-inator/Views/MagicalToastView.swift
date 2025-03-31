//
//  MagicalToastView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-31.
//

import SwiftUI

struct MagicalToastView: View {
    let toast: ToastMessage
    
    var body: some View {
        HStack(spacing: 12) {
            iconView
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(toast.title)
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                
                Text(toast.message)
                    .font(.subheadline)
                    .foregroundColor(Color.primary.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("card-background"))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.purple.opacity(0.15), lineWidth: 1)
                )
                .shadow(color: Color("shadow-card").opacity(0.3), radius: 5, x: 0, y: 2)
        )
        .padding()
    }
    
    private var iconView: some View {
        Group {
            switch toast.icon {
            case .spellLevel(let level):
                Image(level.imageName)
                    .resizable()
                    .scaledToFit()
                
                case .schoolIcon(let school):
                Image(school.imageName)
                    .resizable()
                    .scaledToFit()
                
            case .image(let name):
                Image(name)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}


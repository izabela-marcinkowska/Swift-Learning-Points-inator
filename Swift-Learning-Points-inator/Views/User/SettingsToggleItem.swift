//
//  SettingsToggleItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-30.
//

import SwiftUI
import SwiftData

struct SettingsToggleItem: View {
    let icon: String
    let title: String
    let subtitle: String?
    @Binding var isOn: Bool
    let action: (Bool) -> Void
    
    init(icon: String, title: String, subtitle: String? = nil, isOn: Binding<Bool>, action: @escaping (Bool) -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 30) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .onChange(of: isOn) { oldValue, newValue in
                        action(newValue)
                }
                .tint(Color("accent-color"))
        }
        .padding()
        .withCardStyle(useGradient: false)
    }
}

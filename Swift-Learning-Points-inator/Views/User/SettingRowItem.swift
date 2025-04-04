//
//  SettingRowItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-12.
//

import SwiftUI

struct SettingsRowItem: View {
    let icon: String
    let title: String
    let action: () -> Void
    var subtitle: String? = nil
    var showChevron: Bool = true
    
    var body: some View {
        Button(action: action) {
            HStack (spacing: 10) {
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
                
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .withCardStyle(useGradient: false)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

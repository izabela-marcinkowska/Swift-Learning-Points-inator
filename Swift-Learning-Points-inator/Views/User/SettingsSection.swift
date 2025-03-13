//
//  SettingsSection.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-13.
//

import SwiftUI

struct SettingsSection: View {
    let title: String
    let content: AnyView
    
    init(title: String, @ViewBuilder content: () -> some View) {
        self.title = title
        self.content = AnyView(content())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            content
        }
    }
}

//
//  FilterButton.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-18.
//

import SwiftUI

struct FilterButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
            Text(title)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color("accent-color") : Color.clear)
        .foregroundColor(isSelected ? Color("card-background") : .primary)
        .cornerRadius(8)
    }
}

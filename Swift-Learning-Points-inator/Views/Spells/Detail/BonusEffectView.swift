//
//  BonusEffectView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-03.
//

import SwiftUI

struct BonusEffectView: View {
    let percentage: Double
    let schools: [SchoolOfMagic]
    let isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(schools, id: \.self) { school in
                HStack(spacing: 4) {
                    Text(String(format: "+%.0f%% for", percentage))
                        .font(.caption)
                        .foregroundColor(isActive ? Color("accent-color") : Color.primary)
                        .opacity(isActive ? 1.0 : 0.3)
                    
                    Image(school.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .opacity(isActive ? 1.0 : 0.3)
                    
                    Text(school.rawValue)
                        .font(.caption2)
                        .foregroundColor(isActive ? Color("accent-color") : Color.primary)
                        .opacity(isActive ? 1.0 : 0.3)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

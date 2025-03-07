//
//  ManaDisplayView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-07.
//

import SwiftUI
import SwiftData

struct ManaDisplayView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    var body: some View {
        HStack(spacing: 1) {
            Image("diamond")
                .resizable()
                .scaledToFit()
                .frame(width: 46, height: 46)
            Text("\(user?.mana ?? 0)")
                .font(.system(size: 22, weight: .black, design: .rounded))
                .monospacedDigit()
                .foregroundColor(.purple)
                .shadow(color: .pink.opacity(0.3), radius: 1, x: 1, y: 1)
                .frame(maxHeight: .infinity, alignment: .center)
        }
    }
}

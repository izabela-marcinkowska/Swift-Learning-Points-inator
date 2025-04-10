//
//  StreakDisplayView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-07.
//

import SwiftUI
import SwiftData

struct StreakDisplayView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {

                    
                Image("red-streak-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            Text("\(user?.streak ?? 0)")
                .font(.system(size: 22, weight: .black, design: .rounded))
                .monospacedDigit()
                .foregroundColor(.red)
                .shadow(color: .orange.opacity(0.3), radius: 1, x: 1, y: 1)
                .frame(maxHeight: .infinity, alignment: .center)
                .offset(y: 3)
        }
    }
}


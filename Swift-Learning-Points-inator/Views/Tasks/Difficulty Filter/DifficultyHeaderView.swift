//
//  DifficultyHeaderView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-24.
//

import SwiftUI

struct DifficultyHeaderView: View {
    let difficulty: TaskDifficulty
    
    var body: some View {
        VStack (spacing: 16) {
            Image(difficulty.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}


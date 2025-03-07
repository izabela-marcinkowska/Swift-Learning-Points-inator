//
//  ManaIndicator.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-26.
//

import SwiftUI

struct ManaIndicator: View {
    let amount: Int
    
    var body: some View {
            ZStack {
                Image("diamond")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)

                VStack(spacing: 2) {
                    Text("\(amount)")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color("mana-number-color"))
                }
            }
        }
}


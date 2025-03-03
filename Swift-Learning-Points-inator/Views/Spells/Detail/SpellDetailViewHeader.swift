//
//  SpellDetailViewHeader.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-03.
//

import SwiftUI

struct SpellDetailViewHeader: View {
    let spell: Spell
    
    var body: some View {
        VStack (spacing: 16) {
            Image(spell.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            Text(spell.name)
                .font(.title2.bold())
            
            Text(spell.spellDescription)
                .font(.body)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}


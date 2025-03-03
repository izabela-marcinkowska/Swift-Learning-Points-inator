//
//  SpellLevelRow.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-03-03.
//

import SwiftUI

struct SpellLevelRow: View {
    let level: SpellLevel
    let isAchieved: Bool
    let isCurrent: Bool
    let progressValue: Double
    let spell: Spell
    let showDivider: Bool

    var body: some View {
        VStack(spacing: 5) {
            SpellLevelMilestone(
                level: level,
                isArchieved: isAchieved,
                isCurrent: isCurrent,
                progressValue: progressValue,
                spell: spell
            )
            if showDivider {
                Divider()
                    .padding(.top, 6)
            }
        }
    }
}

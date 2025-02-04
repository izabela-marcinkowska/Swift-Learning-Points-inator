//
//  Affirmation.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-04.
//

import Foundation
import SwiftData

@Model
class Affirmation: Identifiable {
    var id: UUID
    var text: String
    var createdAt: Date
    var isUserCreated: Bool
    var lastDisplayedDate: Date?
    private var categoryRaw: String
    
    var category: AffirmationCategory {
        get {
            AffirmationCategory(rawValue: categoryRaw) ?? .learning
        }
        set {
            categoryRaw = newValue.rawValue
        }
    }
    
    init(
        id: UUID = .init(),
        text: String,
        category: AffirmationCategory,
        createdAt: Date = Date(),
        isUserCreated: Bool = false,
        lastDisplayedAt: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.categoryRaw = category.rawValue
        self.createdAt = createdAt
        self.isUserCreated = isUserCreated
        self.lastDisplayedDate = lastDisplayedDate
    }
}


enum AffirmationCategory: String, CaseIterable {
    case learning = "Learning Growth"
    case persistence = "Persistence"
    case confidence = "Confidence"
    case creativity = "Creativity"
    case wellbeing = "Well-being"
    
    var description: String {
        switch self {
        case .learning:
            return "Affirmations focused on embracing the learning journey"
        case .persistence:
            return "Affirmations about overcoming challenges"
        case .confidence:
            return "Affirmations to boost self-belief in coding abilities"
        case .creativity:
            return "Affirmations about creative problem-solving"
        case .wellbeing:
            return "Affirmations promoting balance and self-care"
        }
    }
}

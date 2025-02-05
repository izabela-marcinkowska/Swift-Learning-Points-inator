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

extension Affirmation {
    var isEligibleToShow: Bool {
        guard let lastShown = lastDisplayedDate else {
            return true
        }
        
        let calendar = Calendar.current
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) else {
            return false
        }
        
        return lastShown < sevenDaysAgo
    }
}

@Model
class AffirmationManager {
    var lastUpdateDate: Date
    
    init(lastUpdateDate: Date = Date()) {
        self.lastUpdateDate = lastUpdateDate
    }
    
    func getRandomAffirmation(context: ModelContext) throws -> Affirmation? {
        let descriptor = FetchDescriptor<Affirmation>()
        let allAffirmation = try context.fetch(descriptor)
        
        let eligibleAffirmations = allAffirmation.filter {$0.isEligibleToShow}
        
        if eligibleAffirmations.isEmpty {
            allAffirmation.forEach { $0.lastDisplayedDate = nil }
            try context.save()
            return allAffirmation.randomElement()
        }
        
        let selected = eligibleAffirmations.randomElement()
        selected?.lastDisplayedDate = Date()
        try context.save()
        
        return selected
        
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

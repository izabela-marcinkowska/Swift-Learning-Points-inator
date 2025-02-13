//
//  Affirmation.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-04.
//

import Foundation
import SwiftData

/// Represents a single affirmation message that can be shown to users to encourage and motivate them
/// in their learning journey.
@Model
class Affirmation: Identifiable {
    var id: UUID
    var text: String
    var createdAt: Date
    var isUserCreated: Bool
    var lastDisplayedDate: Date?
    private var categoryRaw: String
    
    /// The category this affirmation belongs to
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
        lastDisplayedDate: Date? = nil
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
    /// Determines if an affirmation is eligible to be shown based on when it was last displayed.
    /// An affirmation becomes eligible again 7 days after it was last shown.
    var isEligibleToShow: Bool {
        guard let lastShown = lastDisplayedDate else {
            return true // Never shown before
        }
        
        let calendar = Calendar.current
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) else {
            return false
        }
        
        return lastShown < sevenDaysAgo
    }
}

/// Manages the selection and rotation of daily affirmations shown to the user.
/// Ensures that affirmations are properly cycled and not repeated too frequently.
@Model
class AffirmationManager {
    var lastUpdateDate: Date
    var currentAffirmationId: UUID?
    
    init(lastUpdateDate: Date = Date()) {
        self.lastUpdateDate = lastUpdateDate
    }
    
    /// Determines if a new affirmation should be selected for today
    var needsNewAffirmation: Bool {
        let calendar = Calendar.current
        return !calendar.isDateInToday(lastUpdateDate)
    }
    
    /// Retrieves the appropriate affirmation for today, either returning the existing one
    /// or selecting a new one if needed.
    /// - Parameter context: The SwiftData context to fetch affirmations from
    /// - Returns: The selected affirmation, or nil if none are available
    /// - Throws: Any errors that occur during database operations
    func getDailyAffirmation(context: ModelContext) throws -> Affirmation? {
            // If we already have today's affirmation, fetch and return it
            if !needsNewAffirmation, let currentId = currentAffirmationId {
                let descriptor = FetchDescriptor<Affirmation>(
                    predicate: #Predicate<Affirmation> { affirmation in
                        affirmation.id == currentId
                    }
                )
                return try context.fetch(descriptor).first
            }
            
            // Otherwise get a new affirmation
        if let newAffirmation = try getRandomAffirmation(context: context) {
                lastUpdateDate = Date()
                currentAffirmationId = newAffirmation.id
                try context.save()
                return newAffirmation
            }
            
            return nil
        }
    
    /// Selects a random affirmation from the eligible pool, respecting the 7-day cooling period.
    /// If no eligible affirmations exist, resets all cooldowns and picks from the entire pool.
    /// - Parameter context: The SwiftData context to fetch affirmations from
    /// - Returns: The selected affirmation, or nil if none are available
    /// - Throws: Any errors that occur during database operations
    private func getRandomAffirmation(context: ModelContext) throws -> Affirmation? {
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

/// Categories for grouping affirmations by their intended purpose or focus area.
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

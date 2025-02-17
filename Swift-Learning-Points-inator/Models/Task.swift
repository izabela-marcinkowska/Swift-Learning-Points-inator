//
//  Task.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-17.
//

import Foundation
import SwiftData

/// A learning activity that users can complete to earn mana and progress in Schools of Magic.
/// Tasks have specific schools, difficulty levels, and can be either one-time or repeatable daily.
/// When completed, they award mana and contribute to the user's school progress and daily streak.
@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var mana: Int
    private var schoolRaw: String
    var isCompleted: Bool
    var isRepeatable: Bool = false
    private var difficultyRaw: String
    /// The most recent date when this task was successfully completed.
    /// - For non-repeatable tasks: Gets cleared when task is unmarked
    /// - For repeatable tasks: Preserves the last completion date even after unmarking or day reset
    /// Used for historical tracking and displaying completion timestamps to users.
    var lastCompletedDate: Date?
    /// Tracks whether the task has been completed for the current day.
    /// - Gets cleared when unmarking a task
    /// - Gets cleared on daily reset for repeatable tasks
    /// - Used for internal logic to prevent multiple completions per day
    /// Used for determining if repeatable tasks are available for completion today.
    var currentCompletionDate: Date?
    
    /// Computed property controlling if tasks `completedDate` is today.
    var completedToday: Bool {
        guard let currentCompletionDate else { return false }
        return Calendar.current.isDateInToday(currentCompletionDate)
    }
    
    /// Determines if a task can be completed based on its repeatable status and completion state.
    /// - For non-repeatable tasks: Available if not completed today
    /// - For repeatable tasks: Available if not currently completed
    /// - Note: This property will be used in conjunction with the daily task reset mechanism
    var canBeCompleted: Bool {
        if !isRepeatable {
            return !isCompleted
        }
        return !completedToday
    }
    
    /// The difficulty level of the task.
    /// Stored as a raw string value internally for SwiftData compatibility.
    var difficulty: TaskDifficulty {
        get {
            TaskDifficulty(rawValue: difficultyRaw) ?? .easy
        }
        set {
            difficultyRaw = newValue.rawValue
        }
    }
    
    var school: SchoolOfMagic {
        get {
            SchoolOfMagic(rawValue: schoolRaw) ?? .arcaneStudies
        }
        set {
            schoolRaw = newValue.rawValue
        }
    }
    
    
    init(id: UUID = UUID(), name: String, mana: Int, school: SchoolOfMagic = .arcaneStudies, isCompleted: Bool = false, isRepeatable: Bool = false, difficulty: TaskDifficulty = .easy) {
        self.id = id
        self.name = name
        self.mana = mana
        self.schoolRaw = school.rawValue
        self.isCompleted = isCompleted
        self.isRepeatable = isRepeatable
        self.difficultyRaw = difficulty.rawValue
    }
}

//MARK: - Task Completion
extension Task {
    /// Toggles the completion state of a task and updates the user's progress with spell bonuses.
    ///
    /// - Parameters:
    ///   - user: The user whose progress should be updated
    ///   - spells: Array of spells that might provide mana bonuses
    func completeTaskWithBonus(for user: User, spells: [Spell]) {
        guard !isCompleted else { return }
        
        isCompleted = true
        let now = Date()
        lastCompletedDate = now
        currentCompletionDate = now
        
        let breakdown = calculateManaBreakdown(for: user, spells: spells)
        user.mana += breakdown.total
        user.addMana(breakdown.total, for: school)
        user.updateStreak()
    }
    
    /// Reverts a task's completion state and removes awarded mana from the user with bonuses
    /// /// - Parameters:
    ///   - user: The user whose progress should be updated
    ///   - spells: Array of spells that were used for bonus calculation
    func unmarkTask(for user: User, spells: [Spell]) {
        guard isCompleted else { return }
        
        isCompleted = false
        if !isRepeatable {
            lastCompletedDate = nil
            currentCompletionDate = nil
        } else {
            currentCompletionDate = nil
        }
        
        let breakdown = calculateManaBreakdown(for: user, spells: spells)
        user.mana -= breakdown.total
        user.addMana(-breakdown.total, for: school)
    }
}

extension Task {
    /// Reverts a task's completion state and removes awarded mana from the user without bonuses
    ///
    /// - Parameters:
    ///   - user: The user whose progress should be updated
    func completeTaskWithoutBonus(for user: User) {
        guard !isCompleted else { return }
        
        isCompleted = true
        let now = Date()
        lastCompletedDate = now
        currentCompletionDate = now
        
        user.mana += mana
        user.addMana(mana, for: school)
        user.updateStreak()
    }
    
    func unmarkTaskWithoutBonus(for user: User) {
        guard isCompleted else { return }
        
        isCompleted = false
        if !isRepeatable {
            lastCompletedDate = nil
            currentCompletionDate = nil
        } else {
            currentCompletionDate = nil
        }
        
        user.mana -= mana
        user.addMana(-mana, for: school)
    }
}

extension Task {
    static func recentlyCompleted(context: ModelContext, limit: Int = 2) -> [Task] {
        var descriptor = FetchDescriptor<Task>(
            predicate: #Predicate<Task> { task in
                task.lastCompletedDate != nil
            }
        )

        descriptor.sortBy = [SortDescriptor(\.lastCompletedDate, order: .reverse)]
        descriptor.fetchLimit = limit
        
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Error fetching recent tasks: \(error)")
            return []
        }
    }
}

// MARK: - Task Difficulty
/// Represents the difficulty levels available for tasks,
/// affecting suggested mana rewards and visual representation
enum TaskDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var icon: String {
        switch self {
        case .easy: return "1.circle"
        case .medium: return "2.circle"
        case .hard: return "3.circle"
        }
    }
    
    // TODO: Implement this in Step 2 Wizard on Add new task view
    var suggestedManaRange: String {
        switch self {
        case .easy: return "20-40"
        case .medium: return "41-80"
        case .hard: return "81-120"
        }
    }
}

// MARK: - Mana Calculation
extension Task {
    /// Calculates the total mana reward for this task, including any applicable spell bonuses.
    /// - Parameters:
    ///   - user: The user for whom to calculate the mana
    ///   - spells: Array of spells that might provide mana bonuses
    /// - Returns: A breakdown of base mana and bonus mana from applicable spells
    func calculateManaBreakdown(for user: User, spells: [Spell]) -> ManaCalculator.ManaBreakdown {
        return ManaCalculator.calculateMana(for: self, user: user, spells: spells)
    }
}


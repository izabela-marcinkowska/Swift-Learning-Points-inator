//
//  Swift_Learning_Points_inatorTests.swift
//  Swift-Learning-Points-inatorTests
//
//  Created by Izabela Marcinkowska on 2025-04-30.
//

import Testing
@testable import Swift_Learning_Points_inator
import SwiftUI

struct SchoolProgressTests {
    
    @Test func testCurrentLevelCalculation() {
        // Test that the correct achievement level is calculated based on mana
        
        // Create school progress instances with different mana amounts
        let apprenticeProgress = SchoolProgress(school: .viewAlchemy, totalMana: 0)
        let mageProgress = SchoolProgress(school: .viewAlchemy, totalMana: 500)
        let archmageProgress = SchoolProgress(school: .viewAlchemy, totalMana: 2000)
        let grandSorcererProgress = SchoolProgress(school: .viewAlchemy, totalMana: 6000)
        
        // Test all levels
        #expect(apprenticeProgress.currentLevel == .apprentice)
        #expect(mageProgress.currentLevel == .mage)
        #expect(archmageProgress.currentLevel == .archmage)
        #expect(grandSorcererProgress.currentLevel == .grandSorcerer)
    }
    
    @Test func testNextLevelCalculation() {
        // Test that nextLevel property returns the correct next level
        
        let apprenticeProgress = SchoolProgress(school: .viewAlchemy, totalMana: 0)
        let mageProgress = SchoolProgress(school: .viewAlchemy, totalMana: 500)
        let archmageProgress = SchoolProgress(school: .viewAlchemy, totalMana: 2000)
        let grandSorcererProgress = SchoolProgress(school: .viewAlchemy, totalMana: 6000)
        
        #expect(apprenticeProgress.nextLevel == .mage)
        #expect(mageProgress.nextLevel == .archmage)
        #expect(archmageProgress.nextLevel == .grandSorcerer)
        #expect(grandSorcererProgress.nextLevel == nil)
    }
    
    @Test func testProgressToNextLevel() {
        // Test that progress percentage calculation works correctly
        
        // At start of apprentice level (0 progress)
        let newApprentice = SchoolProgress(school: .viewAlchemy, totalMana: 0)
        #expect(newApprentice.progressToNextLevel == 0.0)
        
        // Halfway through apprentice level
        let midApprentice = SchoolProgress(school: .viewAlchemy, totalMana: 250)
        #expect(midApprentice.progressToNextLevel == 0.5)
        
        // At max level (should be 1.0)
        let maxLevel = SchoolProgress(school: .viewAlchemy, totalMana: 6000)
        #expect(maxLevel.progressToNextLevel == 1.0)
    }
    
    @Test func testManaNeededForNextLevel() {
        // Test calculation of how much more mana is needed for next level
        
        let apprentice = SchoolProgress(school: .viewAlchemy, totalMana: 100)
        #expect(apprentice.manaNeededForNextLevel == 400) // 500 - 100
        
        let mage = SchoolProgress(school: .viewAlchemy, totalMana: 1000)
        #expect(mage.manaNeededForNextLevel == 1000) // 2000 - 1000
        
        let grandSorcerer = SchoolProgress(school: .viewAlchemy, totalMana: 6000)
        #expect(grandSorcerer.manaNeededForNextLevel == 0) // Already at max level
    }
}

struct UserTests {
    
    @Test func testStreakStatus() {
        // Create a user with no streak
        let user = User(name: "Test User", mana: 0, streak: 0)
        
        // Without a last streak date, status should be noStreak
        #expect(user.checkStreakStatus() == .noStreak)
        
        // Set a streak date for today
        user.lastStreakDate = Date()
        #expect(user.checkStreakStatus() == .continuing)
        
        // Set streak date to yesterday and check if it's continuing
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            user.lastStreakDate = yesterday
            #expect(user.checkStreakStatus() == .continuing)
        }
        
        // Set streak date to two days ago and check if it's broken
        if let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date()) {
            user.lastStreakDate = twoDaysAgo
            #expect(user.checkStreakStatus() == .broken)
        }
    }
    
    @Test func testStreakUpdate() {
        // Create a user with no streak
        let user = User(name: "Test User", mana: 0, streak: 0)
        
        // Update streak with no previous streak
        user.updateStreak()
        #expect(user.streak == 1)
        #expect(Calendar.current.isDateInToday(user.lastStreakDate ?? Date.distantPast))
        
        // Reset to test continuing streak
        user.streak = 5
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            user.lastStreakDate = yesterday
            user.updateStreak()
            #expect(user.streak == 6)
        }
        
        // Reset to test broken streak
        user.streak = 10
        if let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date()) {
            user.lastStreakDate = threeDaysAgo
            user.updateStreak()
            #expect(user.streak == 1) // Should reset to 1 if streak is broken
        }
    }
    
    @Test func testAddMana() {
        // Create a user and a school progress
        let user = User(name: "Test User")
        
        // Verify initial mana
        #expect(user.mana == 0)
        
        // Add mana to a specific school
        user.addMana(100, for: .viewAlchemy)
        
        // Verify total user mana not affected (it should only go up when completing tasks)
        #expect(user.mana == 0)
        
        // Check that school progress updated correctly
        let viewAlchemyProgress = user.getSchoolProgress(for: .viewAlchemy)
        #expect(viewAlchemyProgress?.totalMana == 100)
    }
    
    @Test func testLevelUpDetection() {
        // Create a user
        let user = User(name: "Test User")
        
        // Set up a school with mana just below level threshold
        user.addMana(499, for: .viewAlchemy)
        
        // Test that one more mana would cause level up
        #expect(user.wouldLevelUp(withAdditionalMana: 1, for: .viewAlchemy))
        
        // Test that adding mana within same level doesn't trigger level up
        user.addMana(50, for: .stateSorcery)
        #expect(!user.wouldLevelUp(withAdditionalMana: 50, for: .stateSorcery))
    }
}

struct TaskTests {
    
    @Test func testTaskCompletion() {
        // Create a user and a task
        let user = User(name: "Test User", mana: 0, streak: 0)
        let task = Task(name: "Test Task", mana: 50, school: .viewAlchemy)
        
        // Initially task should not be completed
        #expect(!task.isCompleted)
        
        // Complete the task
        task.completeTaskWithoutBonus(for: user)
        
        // Verify task is now marked complete
        #expect(task.isCompleted)
        
        // Verify mana was awarded to user
        #expect(user.mana == 50)
        
        // Verify mana was added to the correct school
        let schoolProgress = user.getSchoolProgress(for: .viewAlchemy)
        #expect(schoolProgress?.totalMana == 50)
    }
    
    @Test func testTaskUnmarking() {
        // Create a user and a task
        let user = User(name: "Test User", mana: 100, streak: 1)
        let task = Task(name: "Test Task", mana: 50, school: .viewAlchemy)
        
        // Setup: Add some mana to the school first
        user.addMana(50, for: .viewAlchemy)
        
        // First complete the task
        task.completeTaskWithoutBonus(for: user)
        #expect(task.isCompleted)
        #expect(user.mana == 150) // 100 initial + 50 from task
        
        // Now unmark the task
        task.unmarkTaskWithoutBonus(for: user)
        
        // Verify task is now not completed
        #expect(!task.isCompleted)
        
        // Verify mana was removed from user
        #expect(user.mana == 100) // Back to initial
        
        // Verify mana was removed from the correct school
        let schoolProgress = user.getSchoolProgress(for: .viewAlchemy)
        #expect(schoolProgress?.totalMana == 50) // Back to initial
    }
    
    @Test func testRepeatableTaskBehavior() {
        // Create a user and a repeatable task
        let user = User(name: "Test User", mana: 0)
        let task = Task(name: "Repeatable Task", mana: 30, school: .viewAlchemy, isRepeatable: true)
        
        // Complete the task
        task.completeTaskWithoutBonus(for: user)
        #expect(task.isCompleted)
        #expect(task.completedToday)
        
        // Unmark the task
        task.unmarkTaskWithoutBonus(for: user)
        
        // For repeatable tasks, lastCompletedDate should be preserved but current completion reset
        #expect(!task.isCompleted)
        #expect(!task.completedToday)
        #expect(task.lastCompletedDate != nil)
    }
    
    @Test func testCanBeCompleted() {
        // Test regular non-repeatable task
        let nonRepeatableTask = Task(name: "One-time Task", mana: 20, isRepeatable: false)
        #expect(nonRepeatableTask.canBeCompleted) // Initially can be completed
        
        nonRepeatableTask.isCompleted = true
        #expect(!nonRepeatableTask.canBeCompleted) // Cannot be completed once marked
        
        // Test repeatable task
        let repeatableTask = Task(name: "Daily Task", mana: 20, isRepeatable: true)
        #expect(repeatableTask.canBeCompleted) // Initially can be completed
        
        repeatableTask.isCompleted = true
        repeatableTask.currentCompletionDate = Date()
        #expect(!repeatableTask.canBeCompleted) // Cannot be completed again today
    }
}

struct SpellTests {
    
    @Test func testSpellLevelCalculation() {
        // Test that spell levels are correctly calculated based on invested mana
        
        // Novice level (0 mana)
        let noviceSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand")
        #expect(noviceSpell.currentSpellLevel == .novice)
        
        // Adept level (500 mana)
        let adeptSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 500)
        #expect(adeptSpell.currentSpellLevel == .adept)
        
        // Expert level (1500 mana)
        let expertSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 1500)
        #expect(expertSpell.currentSpellLevel == .expert)
        
        // Master level (4000 mana)
        let masterSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 4000)
        #expect(masterSpell.currentSpellLevel == .master)
    }
    
    @Test func testNextSpellLevel() {
        // Test that nextSpellLevel property returns the correct next level
        
        let noviceSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand")
        #expect(noviceSpell.nextSpellLevel == .adept)
        
        let adeptSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 500)
        #expect(adeptSpell.nextSpellLevel == .expert)
        
        let expertSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 1500)
        #expect(expertSpell.nextSpellLevel == .master)
        
        let masterSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 4000)
        #expect(masterSpell.nextSpellLevel == nil) // No level after master
    }
    
    @Test func testProgressToNextLevel() {
        // Test progress percentage calculation
        
        // 0% progress to adept
        let newSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 0)
        #expect(newSpell.progressToNextLevel == 0.0)
        
        // 50% progress to adept
        let halfwayToAdept = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 250)
        #expect(halfwayToAdept.progressToNextLevel == 0.5)
        
        // 100% progress (master level)
        let masterSpell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 4000)
        #expect(masterSpell.progressToNextLevel == 1.0)
    }
    
    @Test func testManaInvestment() {
        // Test mana investment logic
        
        let spell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand")
        let user = User(name: "Test User", mana: 1000)
        
        // Successful investment
        let investmentSuccess = spell.investMana(amount: 500, from: user)
        #expect(investmentSuccess)
        #expect(spell.investedMana == 500)
        #expect(user.mana == 500) // 1000 - 500
        
        // Investment fails if user doesn't have enough mana
        let investmentFailure = spell.investMana(amount: 1000, from: user)
        #expect(!investmentFailure)
        #expect(spell.investedMana == 500) // Unchanged
        #expect(user.mana == 500) // Unchanged
    }
    
    @Test func testLevelUpDetection() {
        // Test that would level up function works correctly
        
        let spell = Spell(name: "Test Spell", spellDescription: "For testing", category: .steadyPractice, icon: "wand", investedMana: 400)
        
        // Should level up with 100 more mana (to 500 = adept)
        #expect(spell.wouldLevelUp(withAdditionalMana: 100))
        
        // Shouldn't level up with small amount
        #expect(!spell.wouldLevelUp(withAdditionalMana: 50))
        
        // Investing a large amount that crosses multiple levels
        #expect(spell.wouldLevelUp(withAdditionalMana: 3600)) // From 400 to 4000 = master
    }
}

struct ManaCalculatorTests {
    
    @Test func testBasicManaCalculation() {
        // Create a simple task, user, and empty spell list
        let task = Task(name: "Test Task", mana: 100, school: .viewAlchemy)
        let user = User(name: "Test User")
        let spells: [Spell] = []
        
        // Calculate mana with no spells (just base mana)
        let breakdown = ManaCalculator.calculateMana(for: task, user: user, spells: spells)
        
        // With no spells, total should equal base mana
        #expect(breakdown.baseMana == 100)
        #expect(breakdown.totalBonus == 0)
        #expect(breakdown.total == 100)
    }
    
    @Test func testSpellBonusCalculation() {
        // Create a task for View Alchemy school
        let task = Task(name: "Test Task", mana: 100, school: .viewAlchemy)
        let user = User(name: "Test User")
        
        // Create a spell that affects View Alchemy
        // First, we need to ensure the category affects the right school
        let spell = Spell(
            name: "Test Spell",
            spellDescription: "For testing",
            category: .focusedClarity, // This category should affect viewAlchemy
            icon: "wand",
            investedMana: 500 // Adept level (10% bonus)
        )
        
        // Calculate mana with one spell
        let breakdown = ManaCalculator.calculateMana(for: task, user: user, spells: [spell])
        
        // Check bonus calculation
        // At adept level, bonus should be 10% of base mana
        #expect(breakdown.baseMana == 100)
        #expect(breakdown.bonuses.count == 1)
        #expect(breakdown.totalBonus == 10) // 10% of 100
        #expect(breakdown.total == 110) // 100 + 10
    }
    
    @Test func testMultipleSpellBonuses() {
        // Create a task
        let task = Task(name: "Test Task", mana: 100, school: .stateSorcery)
        let user = User(name: "Test User")
        
        // Create multiple spells affecting the same school
        let spell1 = Spell(
            name: "Spell 1",
            spellDescription: "For testing",
            category: .steadyPractice, // Should affect state sorcery
            icon: "wand",
            investedMana: 500 // Adept (10% bonus)
        )
        
        let spell2 = Spell(
            name: "Spell 2",
            spellDescription: "For testing",
            category: .steadyPractice, // Same category for simplicity
            icon: "wand",
            investedMana: 1500 // Expert (15% bonus)
        )
        
        // Calculate mana with multiple spells
        let breakdown = ManaCalculator.calculateMana(for: task, user: user, spells: [spell1, spell2])
        
        // Both spells should contribute bonuses
        #expect(breakdown.baseMana == 100)
        #expect(breakdown.bonuses.count == 2)
        // Total bonus should be 10% + 15% = 25% of base
        #expect(breakdown.totalBonus == 25)
        #expect(breakdown.total == 125)
    }
    
    @Test func testSpellsNotAffectingSchool() {
        // Create a task
        let task = Task(name: "Test Task", mana: 100, school: .viewAlchemy)
        let user = User(name: "Test User")
        
        // Create a spell for a different school category
        let spell = Spell(
            name: "Wrong School Spell",
            spellDescription: "For testing",
            category: .resilientResolve, // This category should not affect viewAlchemy
            icon: "wand",
            investedMana: 4000 // Master level (20% bonus)
        )
        
        // Calculate mana
        let breakdown = ManaCalculator.calculateMana(for: task, user: user, spells: [spell])
        
        // Spell shouldn't provide any bonus for a non-matching school
        #expect(breakdown.baseMana == 100)
        #expect(breakdown.bonuses.isEmpty)
        #expect(breakdown.totalBonus == 0)
        #expect(breakdown.total == 100)
    }
}


struct NotificationManagerTests {
    
    @Test func testUserPreference() {
        let manager = NotificationManager.shared
        
        // Save original preference to restore later
        let originalPreference = manager.getUserNotificationPreference()
        
        // Test setting and getting notification preference
        manager.setUserNotificationPreference(enabled: true)
        #expect(manager.getUserNotificationPreference() == true)
        
        manager.setUserNotificationPreference(enabled: false)
        #expect(manager.getUserNotificationPreference() == false)
        
        // Restore original preference
        manager.setUserNotificationPreference(enabled: originalPreference)
    }
}

struct TaskResetManagerTests {
    
    @Test func testTaskReset() {
        // Create some repeatable and non-repeatable tasks
        let repeatableTask = Task(name: "Daily Task", mana: 10, isCompleted: true, isRepeatable: true)
        repeatableTask.currentCompletionDate = Date()
        
        let nonRepeatableTask = Task(name: "One-time Task", mana: 30, isCompleted: true, isRepeatable: false)
        nonRepeatableTask.currentCompletionDate = Date()
        
        // Simulate resetting just these tasks
        if repeatableTask.isRepeatable {
            repeatableTask.isCompleted = false
            repeatableTask.currentCompletionDate = nil
        }
        
        // Verify reset behavior
        #expect(!repeatableTask.isCompleted)
        #expect(repeatableTask.currentCompletionDate == nil)
        
        #expect(nonRepeatableTask.isCompleted)
        #expect(nonRepeatableTask.currentCompletionDate != nil)
    }
}

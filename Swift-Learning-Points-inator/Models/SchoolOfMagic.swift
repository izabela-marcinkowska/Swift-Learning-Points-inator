//
//  SchoolOfMagic.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-14.
//

import Foundation
import SwiftUI

/// Represents the different schools of magic in the learning system.
/// Each school focuses on a different aspect of programming, themed as magical disciplines.
enum SchoolOfMagic: String, CaseIterable {
    case viewAlchemy = "View Alchemy"
    case stateSorcery = "State Sorcery"
    case temporalConjurations = "Temporal Conjurations"
    case dataIncantations = "Data Incantations"
    case xcodeArcana = "Xcode Arcana"
    case animationEnchantments = "Animation Enchantments"
    case gestureMysticism = "Gesture Mysticism"
    case layoutLegends = "Layout Legends"
    case accessibilityArcanum = "Accessibility Arcanum"
    case qualityConjurations = "Quality Conjurations"
    case fileDivination = "File Divination"
    case everydayEndeavors = "Everyday Endeavors"
    
    /// SF Symbol icon representing this school of magic
    var icon: String {
        switch self {
        case .viewAlchemy:
            return "wand.and.stars"
        case .stateSorcery:
            return "link"
        case .temporalConjurations:
            return "hourglass"
        case .dataIncantations:
            return "tray.fill"
        case .xcodeArcana:
            return "hammer.fill"
        case .animationEnchantments:
            return "sparkles"
        case .gestureMysticism:
            return "hand.point.up.left.fill"
        case .layoutLegends:
            return "square.grid.2x2.fill"
        case .accessibilityArcanum:
            return "figure.wave"
        case .qualityConjurations:
            return "checkmark.seal.fill"
        case .fileDivination:
            return "doc.text.fill"
        case .everydayEndeavors:
            return "star.circle.fill"
        }
    }
    
    /// 3D icon representing this school of magic
    var imageName: String {
        switch self {
        case .viewAlchemy: return "view-alchemy"
        case .stateSorcery: return "state-sorcery"
        case .temporalConjurations: return "temporal-conjurations"
        case .dataIncantations: return "data-incantations"
        case .xcodeArcana: return "xcode-arcana"
        case .animationEnchantments: return "animation-enchantments"
        case .gestureMysticism: return "gesture-mysticism"
        case .layoutLegends: return "layout-legends"
        case .accessibilityArcanum: return "accessibility-arcanum"
        case .qualityConjurations: return "quality-conjurations"
        case .fileDivination: return "file-divination"
        case .everydayEndeavors: return "everyday-endeavors"
        }
    }

    
    /// Detailed description of what this school of magic teaches
    var description: String {
        switch self {
        case .viewAlchemy:
            return "Transform your ideas into beautiful interfaces with SwiftUI views."
        case .stateSorcery:
            return "Master the flow of data to create dynamic, reactive apps."
        case .temporalConjurations:
            return "Harness concurrency and async operations to command time."
        case .dataIncantations:
            return "Delve into data modeling, persistence, and networking."
        case .xcodeArcana:
            return "Unlock Xcode’s secrets to streamline development."
        case .animationEnchantments:
            return "Bring your interfaces to life with captivating animations."
        case .gestureMysticism:
            return "Create intuitive user interactions with SwiftUI gestures."
        case .layoutLegends:
            return "Design adaptive, responsive layouts that shine on every device."
        case .accessibilityArcanum:
            return "Ensure your apps are accessible and inclusive for all."
        case .qualityConjurations:
            return "Test and refine your code to build robust, maintainable apps."
        case .fileDivination:
            return "Learn to handle file operations and decode data formats with ease."
        case .everydayEndeavors:
            return "Tackle your personal projects and day-to-day tasks beyond SwiftUI."
        }
    }
    
    /// Represents achievement levels that can be attained within each school of magic.
    /// Users progress through these levels by earning mana in school-specific tasks.
    enum AchievementLevel: Int, CaseIterable {
        case apprentice = 0
        case mage = 1
        case archmage = 2
        case grandSorcerer = 3
        
        var title: String {
            switch self {
            case .apprentice: return "Apprentice"
            case .mage: return "Mage"
            case .archmage: return "Archmage"
            case .grandSorcerer: return "Grand Sorcerer"
            }
        }
        
        var imageName: String {
            switch self {
            case .apprentice: return "apprentice"
            case .mage: return "mage"
            case .archmage: return "archmage"
            case .grandSorcerer: return "grandSorcerer"
            }
        }
        
        var color: Color {
                switch self {
                case .apprentice: return .blue
                case .mage: return .green
                case .archmage: return .orange
                case .grandSorcerer: return .purple
                }
            }
        
        /// The amount of mana required to reach this level
        var manaThreshold: Int {
            switch self {
            case .apprentice: return 0
            case .mage: return 500
            case .archmage: return 2000
            case .grandSorcerer: return 6000
            }
        }
        
        /// Determines the achievement level based on accumulated mana
        /// - Parameter mana: Total mana accumulated in the school
        /// - Returns: The highest achievement level reached with this amount of mana
        static func level(for mana: Int) -> AchievementLevel {
            let levels = AchievementLevel.allCases.reversed()
            for level in levels {
                if mana >= level.manaThreshold {
                    return level
                }
            }
            return .apprentice
        }
    }
    
    /// Creates a formatted title combining the achievement level and school specialization
    /// - Parameter level: The achievement level to create the title for
    /// - Returns: A formatted string like "Archmage of Data Sorcery"
    func titleForLevel(_ level: AchievementLevel) -> String {
        switch self {
        case .viewAlchemy:
            return "\(level.title) of UI Crafting"
        case .stateSorcery:
            return "\(level.title) of Data Flow"
        case .temporalConjurations:
            return "\(level.title) of Time Mastery"
        case .dataIncantations:
            return "\(level.title) of Data Mastery"
        case .xcodeArcana:
            return "\(level.title) of Xcode Mastery"
        case .animationEnchantments:
            return "\(level.title) of Motion Magic"
        case .gestureMysticism:
            return "\(level.title) of Touch Mastery"
        case .layoutLegends:
            return "\(level.title) of Design Wisdom"
        case .accessibilityArcanum:
            return "\(level.title) of Inclusive Design"
        case .qualityConjurations:
            return "\(level.title) of Code Perfection"
        case .fileDivination:
            return "\(level.title) of Data Handling"
        case .everydayEndeavors:
            return "\(level.title) of Daily Mastery"
        }
    }
    
}

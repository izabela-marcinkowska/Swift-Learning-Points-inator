//
//  SampleAffirmations.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-06.
//

import Foundation

enum SampleAffirmations {
    static let learningAffirmations: [Affirmation] = [
        // Learning Growth affirmations
        Affirmation(
            text: "Every line of code I write makes me a better programmer",
            category: .learning
        ),
        Affirmation(
            text: "I embrace debugging as an opportunity to learn and grow",
            category: .learning
        ),
        Affirmation(
            text: "My coding skills improve with each project I undertake",
            category: .learning
        )]
    
    static let persistanceAffirmations: [Affirmation] = [
        // Persistence affirmations
        Affirmation(
            text: "Errors and bugs are stepping stones to mastery",
            category: .persistence
        ),
        Affirmation(
            text: "I persist through challenges, knowing they make me stronger",
            category: .persistence
        ),
        Affirmation(
            text: "Every obstacle in my code is an opportunity to learn",
            category: .persistence
        )]
    
    static let confidenceAffirmations: [Affirmation] = [
        // Confidence affirmations
        Affirmation(
            text: "I am capable of solving complex programming problems",
            category: .confidence
        ),
        Affirmation(
            text: "My unique perspective brings value to my coding projects",
            category: .confidence
        ),
        Affirmation(
            text: "I trust in my ability to learn and master new technologies",
            category: .confidence
        )]
    
    static let creativityAffirmations: [Affirmation] = [
        // Creativity affirmations
        Affirmation(
            text: "I approach coding challenges with creativity and innovation",
            category: .creativity
        ),
        Affirmation(
            text: "My imagination helps me find elegant solutions",
            category: .creativity
        ),
        Affirmation(
            text: "I see each project as a canvas for creative expression",
            category: .creativity
        )]
    
    static let wellBeingAffirmations: [Affirmation] = [
        // Well-being affirmations
        Affirmation(
            text: "I maintain a healthy balance between coding and rest",
            category: .wellbeing
        ),
        Affirmation(
            text: "Taking breaks makes me a more effective programmer",
            category: .wellbeing
        ),
        Affirmation(
            text: "My well-being enhances my coding productivity",
            category: .wellbeing
        )]
    
    static var allAffiliations: [Affirmation] {
        return learningAffirmations + persistanceAffirmations + confidenceAffirmations + creativityAffirmations + wellBeingAffirmations
    }
}

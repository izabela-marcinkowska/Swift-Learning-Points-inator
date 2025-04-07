//
//  OnboardingManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-04.
//

import Foundation

class OnboardingManager: ObservableObject {
    @Published var hasCompletedOnboardning: Bool
    
    private let hasCompletedOnboardingKey = "hasCompletedOnboarding"
    
    init() {
        self.hasCompletedOnboardning = UserDefaults.standard.bool(forKey: hasCompletedOnboardingKey)
    }
    
    func completeOnboardning() {
        hasCompletedOnboardning = true
        UserDefaults.standard.set(true, forKey: hasCompletedOnboardingKey)
    }
    
    func resetOmboarding() {
        hasCompletedOnboardning = false
        UserDefaults.standard.set(false, forKey: hasCompletedOnboardingKey)
    }
}

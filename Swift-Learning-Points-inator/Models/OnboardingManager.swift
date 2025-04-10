//
//  OnboardingManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-04.
//

import Foundation

class OnboardingManager: ObservableObject {
    private let onboardingCompletedKey = "hasCompletedOnboarding"
    
    @Published var hasCompletedOnboardning: Bool {
            didSet {
                UserDefaults.standard.set(hasCompletedOnboardning, forKey: onboardingCompletedKey)
            }
        }
    
    init() {
        self.hasCompletedOnboardning = UserDefaults.standard.bool(forKey: onboardingCompletedKey)
    }
    
    func completeOnboardning() {
        hasCompletedOnboardning = true
    }
    
    func resetOmboarding() {
        hasCompletedOnboardning = false
    }
}

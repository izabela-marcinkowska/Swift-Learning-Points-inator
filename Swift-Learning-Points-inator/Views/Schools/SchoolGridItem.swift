//
//  SchooGridItem.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-22.
//

import SwiftUI
import SwiftData

struct SchoolGridItem: View {
    let school: SchoolOfMagic
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    private var user: User? {
        users.first
    }
    
    private var schoolProgress: SchoolProgress? {
            user?.getSchoolProgress(for: school)
        }
    
    private var nextLevel: SchoolOfMagic.AchievementLevel? {
            schoolProgress?.nextLevel
        }
    
    private var manaProgress: String {
            schoolProgress?.manaProgressText ?? "0/0"
        }
    
    private var manaNeededForNextLevel: Int {
            schoolProgress?.manaNeededForNextLevel ?? 0
        }
    
    private var levelUpText: String {
            schoolProgress?.levelUpText ?? "Maximum level achieved"
        }
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack(spacing: 6) {
                Image(schoolProgress?.currentLevel.imageName ?? "apprentice")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                
                Text(schoolProgress?.currentLevel.title ?? "apprentice")
                    .font(.headline)
                    .foregroundColor(Color("accent-color"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
            }
            .frame(height: 40)
            
            Image(school.imageName)
                .resizable()
                .scaledToFit()
                .opacity(0.80)
                .frame(width: 80, height: 80)
            
            Spacer(minLength: 4)
            Text("of \(school.rawValue)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 4)
            Text(levelUpText)
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 270)
        .withCardStyle()
    }
}

//
//  DetailSchoolView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-21.
//

import SwiftUI
import SwiftData

struct DetailSchoolView: View {
    let school: SchoolOfMagic
    @Query private var tasks: [Task]
    
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    @State private var showingTasks = false
    
    private var user: User? {
        users.first
    }
    
    
    
    private var manaProgress: String {
        schoolProgress?.manaProgressText ?? "0/0"
    }
    
    private var schoolProgress: SchoolProgress? {
        user?.getSchoolProgress(for: school)
    }
    
    private var nextLevel: SchoolOfMagic.AchievementLevel? {
        schoolProgress?.nextLevel
    }
    
    private var progressToNextLevel: Double {
        schoolProgress?.progressToNextLevel ?? 0
    }
    
    var body: some View {
        VStack {
            SchoolLevelHeaderView(school: school)
                .padding()
            
            Spacer()
            
            VStack (alignment: .leading){
                LevelProgressionBar(
                    currentLevel: schoolProgress?.currentLevel ?? .apprentice,
                    manaProgress: manaProgress,
                    totalMana: schoolProgress?.totalMana ?? 0
                )
            }
            
            Spacer()
            
            NavigationLink(
                destination: TaskCategoryDetailView(
                    school: school,
                    tasks: tasks.filter { $0.school == school }
                )
            ) {
                Text("Show tasks")
                    .font(.headline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(MagicalButtonStyle())
            .padding()
        }
        .withGradientBackground()
    }
}

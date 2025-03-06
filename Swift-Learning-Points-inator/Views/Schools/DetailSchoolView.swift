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
    
    private var user: User? {
        users.first
    }
    
    private var manaProgress: String {
        let currentMana = schoolProgress?.totalMana ?? 0
        let nextThreshold = nextLevel?.manaThreshold ?? currentMana
        return "\(currentMana)/\(nextThreshold)"
    }
    
    /// Progress tracking for the current school
    private var schoolProgress: SchoolProgress? {
        user?.schoolProgress.first { $0.school == school}
    }
    
    /// Calculates the next achievement level if available.
    /// Returns nil if user is already at the maximum level.
    private var nextLevel: SchoolOfMagic.AchievementLevel? {
        guard let currentLevel = schoolProgress?.currentLevel,
              currentLevel.rawValue < SchoolOfMagic.AchievementLevel.allCases.count - 1 else {
            return nil
        }
        return SchoolOfMagic.AchievementLevel(rawValue: currentLevel.rawValue + 1)
    }
    
    /// Calculates progress towards the next level as a value between 0 and 1.
    /// This value is used for the progress bar visualization.
    ///
    /// The calculation works as follows:
    /// 1. Checks if we have all required values (current level, mana, and next level exists)
    /// 2. Gets mana thresholds for current and next level
    /// 3. Calculates how much mana is needed for next level
    /// 4. Determines current progress within that range
    /// 5. Returns progress as a percentage (0-1)
    ///
    /// Returns 0 if:
    /// - User has no progress
    /// - Current level is missing
    /// - User is at maximum level
    private var progressToNextLevel: Double {
        guard let currentLevel = schoolProgress?.currentLevel,
              let currentMana = schoolProgress?.totalMana,
              let nextLevel = nextLevel else {
            return 0
        }
        
        let currentThreshold = currentLevel.manaThreshold
        let nextThreshold = nextLevel.manaThreshold
        let manaForNextLevel = nextThreshold - currentThreshold
        let currentProgress = currentMana - currentThreshold
        
        return Double(currentProgress) / Double(manaForNextLevel)
    }
    
    private var uncompletedTasks: [Task] {
        tasks.filter {$0.school == school && !$0.isCompleted}
    }
    
    private var completedTasks: [Task] {
        tasks.filter {$0.school == school && $0.isCompleted}
    }
    
    var body: some View {
        VStack {
            SchoolLevelHeaderView(school: school)
                .padding()
            
            Text("Mana: \(schoolProgress?.totalMana ?? 0)")
            
            ProgressView(value: progressToNextLevel)
                .padding(.horizontal)
            
            VStack (alignment: .leading){
               
                
                LevelProgressionBar(
                    currentLevel: schoolProgress?.currentLevel ?? .apprentice,
                    manaProgress: manaProgress
                )
            }
            
            //            List {
            //                Section {
            //                    if !uncompletedTasks.isEmpty {
            //                        Section("Uncompleted Tasks") {
            //                            ForEach(uncompletedTasks) { task in
            //                                TaskRowItem(task: task, showIcon: true, showSchoolName: true)
            //                            }
            //                        }
            //                    }
            //
            //                    if !completedTasks.isEmpty {
            //                        Section("Completed Tasks") {
            //                            ForEach(completedTasks) { task in
            //                                TaskRowItem(task: task, showIcon: true, showSchoolName: true)
            //                            }
            //                        }
            //                    }
            //                }
            //            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("background-color"),
                    Color("background-color").opacity(0.9),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
#Preview {
    NavigationStack {
        DetailSchoolView(school: .everydayEndeavors)
    }
}

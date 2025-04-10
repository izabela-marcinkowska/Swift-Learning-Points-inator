//
//  DashboardView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-27.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    @Query private var spells: [Spell]
    @Query private var tasks: [Task]
    
    /// Recently completed tasks, limited to the 2 most recent.
    /// Tasks are sorted by completion date, with most recent first.
    /// Only includes tasks that have a completion date.
    private var recentTasks: [Task] {
        tasks.filter {$0.lastCompletedDate != nil}
            .sorted { ($0.lastCompletedDate ?? .distantPast) > ($1.lastCompletedDate ?? .distantPast) }
            .prefix(2)
            .map { $0 }
    }
    
    func getBackgroundImage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 7 && hour < 19 {
            return "background-day"
        } else {
            return "background-evening"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: -5) {
                ZStack {
                    GeometryReader { geometry in
                        Image(getBackgroundImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                    }
                    .ignoresSafeArea()
                    
                    // White glow shape

                    // Main witch image
                    Image(user?.gender.avatarName ?? "female-avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 180)
                }
                .frame(maxHeight: 180)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Welcome, \(user?.name ?? "Apprentice")")
                            .font(.title)
                        Spacer()
                    }
                    AffirmationWindow()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if let user = user,
                       let achievement = user.getMostRecentAchievement(spells: spells) {
                        RecentAchievementView(achievement: achievement)
                    }
                    
                    if !recentTasks.isEmpty {
                        RecentTasksView(tasks: recentTasks)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("card-background"),
                            Color("card-background").opacity(0.9),
                            Color.black
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(
                    RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                )
            }
            
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ManaDisplayView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    StreakDisplayView()
                }
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    let container = try! ModelContainer(for: User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    context.insert(User(name: "Bella", mana: 42, streak: 5))
    
    return DashboardView()
        .modelContainer(container)
}

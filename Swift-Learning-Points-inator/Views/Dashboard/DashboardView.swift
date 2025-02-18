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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Image("dashboard-background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    // White glow shape
                    Circle()
                        .fill(.white)
                        .frame(width: 220, height: 220)
                        .blur(radius: 20)
                        .opacity(0.3)
                    
                    // Main witch image
                    Image("witchexample")
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
                    HStack (spacing: 4) {
                        Image("mana-diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("\(user?.mana ?? 0)")
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 0) {

                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 46, height: 46)
                                .blur(radius: 8)
                                .opacity(0.8)
                                
                            Image("red-streak-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        Text("\(user?.streak ?? 0)")
                            .font(.system(size: 22, weight: .black, design: .rounded))
                                .monospacedDigit()
                                .foregroundColor(.red)
                                .shadow(color: .orange.opacity(0.3), radius: 1, x: 1, y: 1)
                                .frame(maxHeight: .infinity, alignment: .center)
                            .offset(y: 3)
                        
                        
                    }
                }
            }
        }
    }
}

// Helper shape to round specific corners.
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

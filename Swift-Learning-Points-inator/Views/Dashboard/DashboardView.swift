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
    
    private var recentTasks: [Task] {
        tasks.filter {$0.lastCompletedDate != nil}
            .sorted { ($0.lastCompletedDate ?? .distantPast) > ($1.lastCompletedDate ?? .distantPast) }
            .prefix(2)
            .map { $0 }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Cyan background only extends to the top safe area.
                Color.cyan
                    .ignoresSafeArea(edges: .top)
                
                VStack(spacing: 0) {
                    // Your top image.
                    Image("witchexample")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 180)
                    
                    // Sheet-like content with only the top corners rounded.
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
                    .background(Color(.systemBackground))
                    .clipShape(
                        RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack (spacing: 4) {
                        Image("mana-diamond")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("\(user?.mana ?? 0)")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                        Text("\(user?.streak ?? 0)")
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

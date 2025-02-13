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
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(
                        RoundedCorner(radius: 30, corners: [.topLeft, .topRight])
                    )
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

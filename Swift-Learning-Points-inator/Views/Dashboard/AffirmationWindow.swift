//
//  AffirmationWindow.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-08.
//

import SwiftUI
import SwiftData

struct AffirmationWindow: View {
    @Query private var affirmationsManagers: [AffirmationManager]
    @State private var currentAffirmation: Affirmation?
    @Environment(\.modelContext) private var modelContext
    private var affirmationManager: AffirmationManager? { affirmationsManagers.first }
    
    private func fetchDailyAffirmation() {
        guard let manager = affirmationManager else { return }
        do {
            currentAffirmation = try manager.getDailyAffirmation(context: modelContext)
        } catch {
            print("Error fetching affirmation: {\(error)")
        }
    }
    
    
    var body: some View {
        VStack {
            if let affirmation = currentAffirmation {
                Text(affirmation.text)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(minHeight: 80)
        .onAppear {
            fetchDailyAffirmation()
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Affirmation.self, AffirmationManager.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    AffirmationWindow()
        .modelContainer(container)
}

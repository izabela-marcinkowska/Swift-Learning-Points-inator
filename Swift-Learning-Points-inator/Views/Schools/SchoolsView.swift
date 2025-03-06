//
//  SchoolsView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-20.
//

import SwiftUI
import SwiftData

struct SchoolsView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                        NavigationLink {
                            DetailSchoolView(school: school)
                        } label: {
                            SchoolGridItem(school: school)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Schools of Magic")
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
}

#Preview {
    SchoolsView()
}

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
    
    var body: some View {
        List(SchoolOfMagic.allCases, id: \.self) { school in
            NavigationLink {
                DetailSchoolView(school: school)
            } label: {
            HStack {
                Image(systemName: school.icon)
                Text(school.rawValue)
            }
            }
        }
        .navigationTitle("Schools of Magic")
    }
}

#Preview {
    SchoolsView()
}

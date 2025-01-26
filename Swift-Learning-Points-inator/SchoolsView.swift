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
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                        NavigationLink {
                            DetailSchoolView(school: school)
                        } label: {
                            SchooGridItem(school: school)
                                .frame(height: 200)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
            }
        .navigationTitle("Schools of Magic")
        }
    }
}

#Preview {
    SchoolsView()
}

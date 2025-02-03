//
//  SpellBook.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-30.
//

import SwiftUI
import SwiftData

struct SpellBookView: View {
    @Query private var users: [User]
    private var user: User? { users.first }
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(SpellCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            SpellCategoryView(category: category)
                        } label: {
                            SpellCategoryGridItem(category: category)
                                .frame(height: 200)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
            }
        .navigationTitle("Book of Spells")
        }
    }
}

#Preview {
    SpellBookView()
}

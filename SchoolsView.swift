//
//  SchoolsView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-01-20.
//

import SwiftUI
import SwiftData

struct SchoolsView: View {
    var body: some View {
        List(SchoolOfMagic.allCases, id: \.self) { school in
            HStack {
                Image(systemName: school.icon)
                Text(school.rawValue)
            }
        }
        .navigationTitle("Schools of Magic")
    }
}

#Preview {
    SchoolsView()
}

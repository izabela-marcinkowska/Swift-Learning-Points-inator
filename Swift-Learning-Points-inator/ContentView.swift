//
//  ContentView.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var tasks: [Task]
    var body: some View {
        List(tasks) { task in
            VStack {
            Text(task.name)
            Text("\(task.points)")
            }
        }
    }
}

#Preview {
    ContentView()
}

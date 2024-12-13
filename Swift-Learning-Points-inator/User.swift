//
//  User.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2024-12-13.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var points: Int
    var streak: Int
    
    init(name: String = "", points: Int = 0, streak: Int = 0) {
        self.name = name
        self.points = points
        self.streak = streak
    }
}

@Model
class Task: Identifiable {
    var id: UUID
    var name: String
    var points: Int
    var isCompleted: Bool
    
    init(id: UUID = UUID(), name: String, points: Int, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.points = points
        self.isCompleted = isCompleted
    }
}

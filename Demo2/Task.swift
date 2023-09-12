//
//  Task.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import Foundation

struct Task {
    var name: String //task name
    var duration: Int // task duration (mins)
    var due: Date // due date of task
}

extension Task {
    static let sampleData: [Task] =
    [
        Task(name: "Mow the Lawn",
             duration: 60,
             due : Date()),
        Task(name: "Take out garbage",
             duration: 5,
             due : Date()),
        Task(name: "Walk the dog",
             duration: 20,
             due : Date())
    ]
}




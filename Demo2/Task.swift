//
//  Task.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import Foundation

struct Task: Identifiable{
    let id: UUID
    var name: String //task name
    var duration: Int // task duration (mins)
    var due: Date // due date of task
    
    init(id: UUID = UUID(), name: String, duration: Int, due: Date){
        self.id = id
        self.name = name
        self.duration = duration
        self.due = due
        
    }
}

extension Task {
    static let sampleData: [Task] =
    [
        Task(name: "Mow the Lawn",
             duration: 60,
             due : Date()),
        Task(name: "Take out garbage",
             duration: 150,
             due : Date()),
        Task(name: "Walk the dog",
             duration: 20,
             due : Date())
    ]
}

func add(){
   
    //t.append(Task(name: "Mow the Lawn", duration: 60,due : Date()))
print("hello")
}






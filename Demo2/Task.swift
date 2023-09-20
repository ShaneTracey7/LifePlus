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
    var isComplete: Bool // if task is completed or not
    
    
    init(id: UUID = UUID(), name: String, duration: Int, due: Date, isComplete: Bool){
        self.id = id
        self.name = name
        self.duration = duration
        self.due = due
        self.isComplete = isComplete
        
    }
    
    
    static func add(t: [Task], s: String, dur: Int, d: Date){
       
        //t.append(Task(name: s, duration: dur, due: d))
        //t.append(Task(name: "Mow the Lawn", duration: 60,due : Date()))
    print("hello")
    }
    
    static func add2(){
       
        //t.append(Task(name: s, duration: dur, due: d))
        //t.append(Task(name: "Mow the Lawn", duration: 60,due : Date()))
    print("hello2")
    }
}

extension Task {
    static let sampleData: [Task] =
    [
        Task(name: "Mow the Lawn",
             duration: 60,
             due : Date(), isComplete: false),
        Task(name: "Take out garbage",
             duration: 150,
             due : Date(),isComplete: false),
        Task(name: "Walk the dog",
             duration: 20,
             due : Date(),isComplete: false)
    ]
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.duration == rhs.duration &&
            lhs.due == rhs.due &&
            lhs.isComplete == rhs.isComplete
    }
}









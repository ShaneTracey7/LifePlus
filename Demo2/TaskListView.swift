//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    //let tasks: [Task]
    @State var tasks = [
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
    var body: some View {
        
        NavigationStack{
            List(tasks) { task in
                NavigationLink(destination: Text(task.name)) {
                    TaskView(task: task)
                }
            }
            //Button(action: add){
            //   Label("", systemImage: "plus.circle").imageScale(.large)}
            
            
            
            .navigationTitle("Tasks")
            .toolbar {
                Button (action: {tasks.append(Task(name: "Mow the Lawn", duration: 60,due : Date()))}){
                    Image(systemName: "plus")
                    
                }
                .accessibilityLabel("New Task")
            }
        }
        }
    }


struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

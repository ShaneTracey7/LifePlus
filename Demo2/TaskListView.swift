//
//  ListsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [Task]
    var body: some View {
        
        List(tasks) { task in
            TaskView(task: task)
        }
            //Button(action: add){
             //   Label("", systemImage: "plus.circle").imageScale(.large)}
                
            
        }
    }


struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(tasks: Task.sampleData)
    }
}

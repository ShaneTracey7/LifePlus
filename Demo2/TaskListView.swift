//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @Binding var tasks: [Task]
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            ScrollView{
                ForEach(tasks) { task in
                    
                    TaskView(task: task, tasks: self.$tasks)
                    
                }
            }
            
            .navigationTitle("Tasks")
            .toolbar {
                
                NavigationLink(destination: AddTaskView(tasks: self.$tasks)){
                    Image(systemName: "plus")
                }
                
            }
            }
            
            if tasks.isEmpty{
                Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
        }
        .background(Color.white)
        }
    }


struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        @State var tasks = [
            Task(name: "Mow the Lawn",
                 duration: 60,
                 due : Date(),isComplete: false),
            Task(name: "Take out garbage",
                 duration: 150,
                 due : Date(),isComplete: false),
            Task(name: "Walk the dog",
                 duration: 20,
                 due : Date(),isComplete: false)
        ]
            var body: some View {
                TaskListView(tasks: $tasks)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
    }
}



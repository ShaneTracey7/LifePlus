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
                    TaskView(task: task)
                }
            }
            //List(tasks) { task in
                //NavigationLink(destination: Text(task.name)) {
                   // TaskView(task: task)
                //}
           // }
            
            .navigationTitle("Tasks")
            .toolbar {
                
                NavigationLink(destination: AddTaskView(tasks: self.$tasks)){
                    Image(systemName: "plus")
                }
                /*
                 Button (action: {tasks.append(Task(name: "Mow the Lawn", duration: 60,due : Date()))}){
                 Image(systemName: "plus")
                 
                 }
                 .accessibilityLabel("New Task")
                 */
            }
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
                 due : Date()),
            Task(name: "Take out garbage",
                 duration: 150,
                 due : Date()),
            Task(name: "Walk the dog",
                 duration: 20,
                 due : Date())
        ]
            
            var body: some View {
                TaskListView(tasks: $tasks)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
    }
}



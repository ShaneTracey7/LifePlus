//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @Binding var points: Int
    @Binding var rewardPoints: Int
    @Binding var tasks: [Task]
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: TaskEntity.entity(), sortDescriptors: []) var taskentities: FetchedResults<TaskEntity>
    
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            ScrollView{
                ForEach(taskentities) { taske in
                    
                    try{
                    let task = Task(name: taske.name, duration: taske.duration, due: taske.date, isComplete: taske.isComplete)
                    TaskView(task: taske, points: $points, rewardPoints: $rewardPoints, tasks: self.$tasks)
                    
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
        @State var points = 0
        @State var rewardPoints = 0
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
                TaskListView(points: $points,rewardPoints: $rewardPoints, tasks: $tasks)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}



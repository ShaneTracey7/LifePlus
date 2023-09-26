//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @Binding var tasks: [TaskEntity]
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            ScrollView{
                ForEach(vm.taskEntities) { task in
                
                    TaskView(vm: vm, tasks: $tasks,task: task)
                    
                }
            }
            
            .navigationTitle("Tasks")
            .toolbar {
                
                NavigationLink(destination: AddTaskView(vm: self.vm)){
                    Image(systemName: "plus")
                }
                
            }
            }
            
            if vm.taskEntities.isEmpty{
                Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
        }
        .background(Color.white)
        }
    }


struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var tasks: [TaskEntity] = []


            var body: some View {
                TaskListView(vm: vm, tasks: $tasks)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
        
    }
}



//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @Binding var points: Int
    @Binding var rewardPoints: Int
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            ScrollView{
                ForEach(vm.taskEntities) { task in
                
                    TaskView( points: $points, rewardPoints: $rewardPoints,task: task)
                    
                }
            }
            
            .navigationTitle("Tasks")
            .toolbar {
                
                NavigationLink(destination: AddTaskView()){
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
        
        @State var points = 0
        @State var rewardPoints = 0

            var body: some View {
                TaskListView(points: $points,rewardPoints: $rewardPoints)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
        
    }
}



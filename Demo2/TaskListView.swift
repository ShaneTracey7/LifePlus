//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    //@State var doubleCheck: Bool = false
    @State var sortSelection: Int = 0
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            
            Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
            {
                Text("Date").tag(1)
                Text("Duration").tag(2)
                Text("Complete").tag(3)
            }.pickerStyle(.segmented).frame(width: 300)
                .onChange(of: sortSelection) { newValue in
                    vm.sortTask(choice: newValue)
                            }
            
            ScrollView{
                ForEach(vm.taskEntities) { task in
                    
                    TaskView(vm: vm, sortSelection: $sortSelection, task: task)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                
                NavigationLink(destination: AddTaskView(vm: self.vm, sortSelection: $sortSelection)){
                    Image(systemName: "plus")
                }
                
            }
            }
            
            if vm.taskEntities.isEmpty{
                Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        //.background(Color.white)
        }
    }


struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                TaskListView(vm: vm)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
        
    }
}



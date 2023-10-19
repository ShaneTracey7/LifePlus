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
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    
    @Binding var tasklist: ListEntity
    
    var body: some View {
        
        ZStack{
        
            NavigationStack{
                
                if tasklist.style == "task" ||  tasklist.style == "calendar" || tasklist.style == "hybrid"
                {
                    Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
                    {
                        Text("Date").tag(1)
                        Text("Duration").tag(2)
                        Text("Complete").tag(3)
                    }.pickerStyle(.segmented).frame(width: 300)
                        .padding([.bottom], 5)
                        .onChange(of: sortSelection) { newValue in
                            vm.sortTask(choice: newValue)
                        }
                }
                ScrollView{
                    
                    if  tasklist.style == "task"
                    {
                        
                        ForEach(vm.getTaskList(tasklist: tasklist)) { task in
                            
                            TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                        }
                    }
                    else if  tasklist.style == "calendar"
                    {
                        
                        //will have to tweak a few things so that the defaults are displayed in DefaultTaskView
                        
                        //defaults
                        ForEach(vm.getTaskList(tasklist: vm.getDefaultTaskList(tasklist: tasklist)))
                        { task in
                            
                            //putting calendar style tasklist in default tasklist veiw with default task
                            DefaultTaskView(vm: vm, inSettings: false, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                        }
                        //user added
                        ForEach(vm.getTaskList(tasklist: tasklist)) { task in
                            
                            TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                        }
                    }
                    else if tasklist.style == "basic"
                    {
                        ForEach(vm.getTaskList(tasklist: tasklist)) { task in
                            
                            BasicTaskView(vm: vm,tasklist: $tasklist, task: task).padding([.bottom], 5)
                        }
                    }
                    else if tasklist.style == "default"
                    {
                        ForEach(vm.getTaskList(tasklist: tasklist)) { task in

                            DefaultTaskView(vm: vm, inSettings: true, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                        }
                    }
                    else if tasklist.style == "hybrid"
                    {
                        ForEach(vm.getTaskList(tasklist: tasklist)) { task in

                            //is basic task
                            if task.duration == 0
                            {
                                BasicTaskView(vm: vm,tasklist: $tasklist, task: task).padding([.bottom], 5)
                            }
                            // is counter
                            else if task.totalReps > 1
                            {
                                CounterView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                            }
                            // is task
                            else
                            {
                                TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, task: task)
                            }
                        
                        }
                    }
                    else
                    {
                        
                    }
                }
                .navigationTitle(vm.getListName(entity: tasklist))
                .toolbar {
                    
                    if  tasklist.style == "task" || tasklist.style == "calendar"
                    {
                        
                        NavigationLink(destination: AddTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist)){
                            Image(systemName: "plus")
                        }
                    }
                    else if tasklist.style == "basic"
                    {
                        NavigationLink(destination: AddBasicTaskView(vm: self.vm, tasklist: $tasklist)){
                            Image(systemName: "plus")
                        }
                    }
                    else if tasklist.style == "hybrid"
                    {
                        NavigationLink(destination: AddHybridTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist)){
                            Image(systemName: "plus")
                        }
                    }
                    else if tasklist.style == "default"
                    {
                        NavigationLink(destination: AddDefaultTaskView(vm: self.vm, tasklist: $tasklist)){
                            Image(systemName: "plus")
                        }
                    }
                    else
                    {
                        
                    }
                    
                }
            }
            
            if tasklist.style == "calendar"
            {
                if vm.getTaskList(tasklist: tasklist).isEmpty && vm.getTaskList(tasklist: vm.getDefaultTaskList(tasklist: tasklist)).isEmpty
                {
                    Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
                }
            }
            else
            {
                if vm.getTaskList(tasklist: tasklist).isEmpty
                {
                    Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
                }
            }
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        }
    }


struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var tasklist = ListEntity()
            var body: some View {
                TaskListView(vm: vm, tasklist: $tasklist)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
        
    }
}



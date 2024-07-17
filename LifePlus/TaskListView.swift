//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//


import SwiftUI

struct TaskListView: View {
    
    //issue is parly from this veiw
    
    
    @ObservedObject var vm: CoreDataViewModel
    //@State var doubleCheck: Bool = false
    @State var sortSelection: Int = 0
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    @State var inCalendar: Bool = false
    @State var editOn: Bool = false /*new*/
    @State var optionalTask: TaskEntity? = nil
    
    @Binding var tasklist: ListEntity
    
    @State var taskArr: [TaskEntity] = []
    
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
                            taskArr = vm.sortTaskCH(choice: newValue, taskArr: taskArr)
                        }
                }
                ScrollView{
                    
                    if  tasklist.style == "task"
                    {
                        
                        ForEach(taskArr) { task in
                            
                            TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, editOn: $editOn,task: task)
                        }
                    }
                    else if  tasklist.style == "calendar" || /* new */ tasklist.style == "default"
                    {
                        //defaults and added-in-calendar-view tasks are being displayed
                        ForEach(taskArr) { task in
                            
                            //is basic task
                            if task.duration == 0
                            {
                                BasicTaskView(vm: vm,tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task).padding([.bottom], 5)
                            }
                            // is counter
                            else if task.totalReps > 1
                            {
                                CounterView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task)
                            }
                
                            else
                            {
                                TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, editOn: $editOn, task: task)
                            }
                            
                        }
                    }
                    else if tasklist.style == "basic"
                    {
                        ForEach(taskArr) { task in
                            
                            BasicTaskView(vm: vm,tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task).padding([.bottom], 5)
                        }
                    }
                    else if tasklist.style == "hybrid"
                    {
                        ForEach(taskArr) { task in

                            //is basic task
                            if task.duration == 0
                            {
                                BasicTaskView(vm: vm,tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task).padding([.bottom], 5)
                            }
                            // is counter
                            else if task.totalReps > 1
                            {
                                CounterView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task)
                            }
                            // is task
                            else
                            {
                                TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, editOn: $editOn, task: task)
                            }
                        
                        }
                    }
                    else
                    {
                        
                    }
                }
                .navigationTitle(vm.getListName(entity: tasklist))
                .toolbar {
                    
                    
                    //edit tasks button
                    Button {
                        print("complete button was pressed")
                        withAnimation {
                            
                        }
                        //toggle editOn
                        editOn.toggle()
                        
                    } label: {
                        Image(systemName: "pencil.circle").foregroundColor(editOn ? Color.red : Color.white)
                    }
                    //.frame(width: 20, height: 35)
                    .frame(alignment: .trailing).buttonStyle(.plain)
                    //.padding([.trailing],5)
                    
                    
                    
                    
                    
                    
                    if  tasklist.style == "task"
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
                    
                    else //if calendar, default, or hybrid
                    {
                        NavigationLink(destination: AddHybridTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist, task: $optionalTask)){
                            Image(systemName: "plus")
                        }
                    }
                    
                }
            }
            
            /*
            if taskArr.isEmpty
            {
                Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
            */
            
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
        .onAppear
            {
                if tasklist.style == "calendar"
                {
                    taskArr = vm.getCombinedTaskList(tasklist: tasklist)
                }
                else
                {
                    taskArr = vm.getTaskList(tasklist: tasklist)
                }
            }
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

 



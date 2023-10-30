//
//  CalendarTaskListView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-30.
//


import SwiftUI

struct CalendarTaskListView: View {
    
    //issue is parly from this veiw
    
    
    @ObservedObject var vm: CoreDataViewModel
    //@State var doubleCheck: Bool = false
    @State var sortSelection: Int = 0
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    
    @Binding var tasklist: ListEntity
    @State var inCalendar: Bool = true 
    
    @State var taskArr: [TaskEntity] = []
    
    var body: some View {
        
        ZStack{
        
            NavigationStack{
                
                ScrollView{
                    
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
                                TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, task: task)
                            }
                            
                    }
                    
                }
                .navigationTitle(vm.getListName(entity: tasklist))
            }
            
            if vm.getTaskList(tasklist: tasklist).isEmpty && vm.getTaskList(tasklist: vm.getDefaultTaskList(tasklist: tasklist)).isEmpty
            {
                Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
            
            
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear
            {
                taskArr = vm.getCombinedTaskList(tasklist: tasklist)
            }
        }
    }


struct CalendarTaskListView_Previews: PreviewProvider {
    
    struct CalendarTaskListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var tasklist = ListEntity()
            var body: some View {
                CalendarTaskListView(vm: vm, tasklist: $tasklist)
            }
        }
    
    static var previews: some View {
        CalendarTaskListViewContainer()
        
    }
}

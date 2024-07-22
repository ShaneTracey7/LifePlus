//
//  BasicTaskView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-16.
//


import SwiftUI

struct BasicTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    @State var optionalTask: TaskEntity?
    
    @Binding var tasklist: ListEntity
    @Binding var taskArr: [TaskEntity]
    @Binding var inCalendar: Bool
    @Binding var sortSelection: Int
    @Binding var editOn: Bool
    
    let task: TaskEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, and complete and delete buttons
                HStack{
                    
                    //not defaulttask or complete task
                    if !vm.isDefaultTask(task: task) && editOn && !task.isComplete
                    {
                        
                        if tasklist.style == "calendar" || tasklist.style == "hybrid" || tasklist.style == "default"
                        {
                            NavigationLink(destination: AddHybridTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist, task: $optionalTask)){

                                    Text(task.name ?? "No name")
                                        .font(.body)//.font(.title3)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .frame(alignment: .leading)
                                        .padding([.leading], 15)
                                        .padding([.top], 0)
                            }
                            .buttonStyle(PressableButtonStyle())
                            .padding([.trailing], 5)
                            
                            Spacer()
                        }
                        else
                        {
                            NavigationLink(destination: AddBasicTaskView(vm: self.vm, tasklist: $tasklist, task: $optionalTask)){

                                    Text(task.name ?? "No name")
                                        .font(.body)//.font(.title3)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .frame(alignment: .leading)
                                        .padding([.leading], 15)
                                        .padding([.top], 0)
                            }
                            .buttonStyle(PressableButtonStyle())
                            .padding([.trailing], 5)
                            
                            Spacer()
                        }
                        
                    }
                    else
                        {
                        
                        
                        Text(task.name ?? "No name")
                            .font(.body)//.font(.title3)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(alignment: .leading)
                            .padding([.leading], 15)
                        
                        Spacer()
                        
                    }
                    
                   if !vm.isDefaultTaskList(tasklist: tasklist) && !inCalendar
                   {
                       if task.isComplete == false {
                           
                           //task complete button
                           Button {
                               print("complete button was pressed")
                               withAnimation {
                                   task.isComplete.toggle()
                               }
                               //reset sorting in tasklistview
                               
                               task.isComplete = true
                               
                               //change backgroundcolor
                               lightColorChange = Library.lightgreenColor
                               colorChange = Library.greenColor
                               
                               //check if this completes the list
                               vm.listCompleteChecker(tasklist: tasklist)
                               
                           } label: {
                               Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Library.lightgreenColor)
                           }
                           .frame(width: 20, height: 35)
                           .frame(alignment: .trailing).buttonStyle(.plain)
                           .padding([.trailing],vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: tasklist))
                           
                       }
                       else{
                           //undo button
                           Button {
                               print("undo button was pressed")
                               withAnimation {
                                   //task.isComplete.toggle() //idk what this does
                               }
                               //reset sorting in tasklistview
                               
                               task.isComplete = false
                               
                               //change backgroundcolor
                                lightColorChange = Library.lightblueColor
                                colorChange = Library.blueColor
                                                              
                               //don't need to adjust for points since basic tasks have no points
                               //sets list as incomplete
                               vm.listNotCompleteCalendar(tasklist: tasklist)
                               
                           } label: {
                               Image(systemName: "arrow.uturn.right.circle").imageScale(.medium).foregroundColor(Color.blue)
                           }
                           .frame(width: 20, height: 35)
                           .frame(alignment: .trailing).buttonStyle(.plain)
                           .padding([.trailing],vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: tasklist))
                           //Spacer().frame(width: 20, height: 35)
                       }
                   }
                   else
                   {
                       //Spacer().frame(width: 20, height: 35)
                   }
                        
                    if !vm.isDefaultTask(task: task) && !inCalendar || vm.isDefaultTaskList(tasklist: tasklist) && !inCalendar
                    {
                        //delete task button
                        Button(role: .destructive,
                               action: {
                            withAnimation{
                                
                                print("delete button was pressed")
                                doubleCheck = true
                            }
                            
                        },
                               label: {
                            Image(systemName: "trash").imageScale(.medium).foregroundColor(Color.red)
                        })
                        .frame(width: 20, height: 35).frame(alignment: .trailing).padding([.trailing],12).buttonStyle(.plain)
                        .confirmationDialog(
                            "Are you sure?",
                            isPresented: $doubleCheck,
                            titleVisibility: .visible
                        )
                        {
                            Button("Yes", role: .destructive)
                            {
                                let index = vm.activeTaskEntities.firstIndex(of: task)
                                vm.deleteTask(index: index ?? 0)
                                //remove task from taskArr
                                let arrIndex = taskArr.firstIndex(of: task) ?? -1
                                if arrIndex != -1
                                {
                                    taskArr.remove(at: arrIndex)
                                }
                                else
                                {
                                    print("error removing from taskArr")
                                }
                                
                                
                                if vm.isDefaultTask(task: task)
                                {
                                    let calendarIndex = vm.findCalendarListIndex(tasklist: tasklist)
                                    vm.listCompleteChecker(tasklist: vm.calendarListEntities[calendarIndex])
                                }
                                else
                                {
                                    vm.listCompleteChecker(tasklist: tasklist)
                                }
                                
                                
                                print("confirmation delete button was pressed")
                            }
                            Button("No", role: .cancel){}
                            
                        }
                    }
            }.padding([.trailing], 5)
            //.border(Color.red)
                
                    Spacer().frame(height:20)
                
            // contains date and duration
            
            }/*.frame(width:350)*/.frame(maxWidth: .infinity)
        //.border(Color.green)
        
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 40)
                }
                
                .foregroundColor(colorChange)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
    
        }
        /*.frame(width: 410.0)*/.frame(maxWidth: .infinity).padding([.horizontal],20)//.border(Color.blue)
        .onAppear{

            optionalTask = task
            
            if !vm.isDefaultTaskList(tasklist: tasklist)
            {
                //complete
                if task.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
                }
                else if inCalendar
                {
                    lightColorChange = Library.lightredColor
                    colorChange = Library.redColor
                }
                else
                {
                    lightColorChange = Library.lightblueColor
                    colorChange = Library.blueColor
                }
            }
            else
            {
                lightColorChange = Library.lightblueColor
                colorChange = Library.blueColor
            }
            
                
        }
    }
}


struct BasicTaskView_Previews: PreviewProvider {
    
    struct BasicTaskViewContainer: View {
        @State var vm = CoreDataViewModel()

        @State var tasklist: ListEntity = ListEntity()
        @State var taskArr: [TaskEntity] = []
        @State var inCalendar: Bool = false
        @State var sortSelection: Int = 0
        @State var editOn: Bool =  false
        let task: TaskEntity = TaskEntity()
            
            var body: some View {
                BasicTaskView(vm: self.vm, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, sortSelection: $sortSelection, editOn: $editOn, task: task)
                
            }
        }
    
    static var previews: some View {
        BasicTaskViewContainer()
    }
}



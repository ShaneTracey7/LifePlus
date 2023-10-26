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
    
    @Binding var tasklist: ListEntity
    @Binding var taskArr: [TaskEntity]
    
    
    
    let task: TaskEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, and complete and delete buttons
                HStack{
                    
                    Text(task.name ?? "No name")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        //.frame(width:225, alignment: .leading)
                        .frame(alignment: .leading)
                        .padding([.leading], 20)
                    
                    
                    Spacer()
                            
                   if !vm.isDefaultTaskList(tasklist: tasklist)
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
                               Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Color.green)
                           }
                           .frame(width: 20, height: 35)
                           .frame(alignment: .trailing).buttonStyle(.plain)
                           .padding([.trailing],15)
                           
                       }
                       else{
                           Spacer().frame(height: 35)
                       }
                   }
                   else
                   {
                        Spacer().frame(height: 35)
                   }
                        
                    if !vm.isDefaultTask(task: task) || vm.isDefaultTaskList(tasklist: tasklist)
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
                        .frame(width: 20, height: 35).frame(alignment: .trailing).padding([.trailing],15).buttonStyle(.plain)
                        .confirmationDialog(
                            "Are you sure?",
                            isPresented: $doubleCheck,
                            titleVisibility: .visible
                        )
                        {
                            Button("Yes", role: .destructive)
                            {
                                let index = vm.taskEntities.firstIndex(of: task)
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
            
        }.frame(width:350)
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
        .frame(width: 410.0)//.border(Color.blue)
        .onAppear{
                
            
            if !vm.isDefaultTaskList(tasklist: tasklist)
            {
                //complete
                if task.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
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
        let task: TaskEntity = TaskEntity()
            
            var body: some View {
                BasicTaskView(vm: self.vm, tasklist: $tasklist, taskArr: $taskArr, task: task)
                
            }
        }
    
    static var previews: some View {
        BasicTaskViewContainer()
    }
}



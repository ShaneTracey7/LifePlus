//
//  DefaultTaskView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-17.
//

import SwiftUI

struct DefaultTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    
    @State var inSettings: Bool //changes to view depeding on if its being viewed in Settings or in a Calendar list
    @Binding var sortSelection: Int
    @Binding var showPopUp: Bool
    @Binding var namePopUp: String
    @Binding var infoPopUp: String
    @Binding var tasklist: ListEntity
    
    
    
    
    let task: TaskEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, and info, complete and delete buttons
                HStack{
                    
                    Text(task.name ?? "No name")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    //.frame(width:225, alignment: .leading)
                        .frame(alignment: .leading)
                        .padding([.leading], 20)
                    
                    
                    Spacer()
                    
                    if inSettings == false
                    {
                        if task.isComplete == false {
                            
                            //task complete button
                            Button {
                                print("complete button was pressed")
                                withAnimation {
                                    task.isComplete.toggle()
                                }
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                task.isComplete = true
                                
                                //change backgroundcolor
                                lightColorChange = Library.lightgreenColor
                                colorChange = Library.greenColor
                                
                                let add: Int = Int((task.duration * 400) / 60) + 100
                                
                                vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                
                                //for order
                                vm.addPoints(entity: vm.pointEntities[2], increment: 1)
                                vm.setTaskCompletedOrder(entity: task, order: Int(vm.pointEntities[2].value))
                                
                                //incrementing values within goals
                                vm.addToCurrentValue(taskIncrement: 1.0, hourIncrement: (Float(Float(task.duration)/60)))
                                
                                //check if this completes the list
                                vm.listCompleteChecker(tasklist: tasklist)
                                
                            } label: {
                                Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Color.green)
                            }
                            .frame(width: 35, height: 35)
                            .frame(alignment: .trailing).buttonStyle(.plain)
                            
                        }
                        else{
                            //Spacer(minLength: 40).frame(alignment: .trailing)
                        }
                    }
                    Button(action: {
                        
                        namePopUp = task.name ?? ""
                        infoPopUp = task.info ?? ""
                        showPopUp = true
                    }, label: {
                        
                        Image(systemName: "note.text")
                            .font(.title3)
                            .foregroundColor(Color.white)
                    })
                    .buttonStyle(PressableButtonStyle())
                    .frame(width:35, height: 35)
                    
                    //cannot delete a default task from inside a calednat task list
                    
                    
                    if inSettings == true
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
                    .frame(width: 35, height: 35).frame(alignment: .trailing).padding([.trailing],10).buttonStyle(.plain)
                    .confirmationDialog(
                        "Are you sure?",
                        isPresented: $doubleCheck,
                        titleVisibility: .visible
                    )
                    {
                        Button("Yes", role: .destructive)
                        {
                            //reset sorting in tasklistview
                            sortSelection = 0
                                                    
                            if task.isComplete
                            {
                                vm.adjustPoints(task: task)
                            }
                            let index = vm.taskEntities.firstIndex(of: task)
                            vm.deleteTask(index: index ?? 0)
                            vm.listCompleteChecker(tasklist: tasklist)
                            
                            print("confirmation delete button was pressed")
                        }
                        Button("No", role: .cancel){}
                    }
                }
                else
                {
                    //needed for better pacing for info button
                    Spacer().frame(width: 5)
                   
                }
            }//.padding([.top, .bottom], 5)
            //.border(Color.red)
                
                if inSettings == false
                {
                    if task.isComplete == true {
                        Text("Completed").font(.caption2).foregroundColor(Color.green)
                            .frame(alignment: .leading)
                            .padding([.leading],20)
                            .padding([.top],5)
                        //.border(Color.red)
                    }
                    else if task.date ??  Date() < Library.firstSecondOfToday() //implement past due
                    {
                        Text("Past Due").font(.caption2).foregroundColor(Color.red)
                            .frame(alignment: .leading)
                            .padding([.leading],20)
                            .padding([.top],5)
                    }
                    else
                    {
                        Spacer().frame(height:20)
                    }
                }
                else
                {
                    Spacer().frame(height:20)
                }

            // contains date and duration
                HStack{
                    
                    if(tasklist.name == "Daily DEFAULT" || tasklist.name == "Daily TODO")
                    {
                        Text("Complete by: \((task.date ?? Date()).formatted(date: .omitted, time: .shortened))")
                        .font(.body)
                        .foregroundColor(lightColorChange)
                        //.frame(width: 175, alignment: .leading)
                        .frame(alignment: .leading)
                        .padding([.leading],20)
                }
                Spacer()
                
                if (task.duration > 119)
                {
                    let quotient = Double (task.duration) / 60
                    Text("\(String(format: "%.1f", quotient)) hours")
                        .font(.body)
                        //.padding([.trailing],10)
                        .foregroundColor(lightColorChange)
                        .frame(width: 100)
                }
                else
                {
                    Text("\(task.duration) mins").font(.body)
                        //.padding([.trailing],10)
                        .foregroundColor(lightColorChange).frame(width: 100)
                }
                
                
            }
            //.padding([.top, .bottom], 5)
            //.border(Color.red)
                
                Text("date: \((task.date ?? Date()).formatted(date: .abbreviated, time: .shortened))")
            
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
            
            if inSettings == false
            {
                let td = Library.firstSecondOfToday()
                
                //complete
                if task.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
                }
                //past due
                else if task.date ?? Date() < td || tasklist.name == "Daily TODO" && task.date ?? Date() < Date()
                {
                    lightColorChange = Library.lightredColor
                    colorChange = Library.redColor
                }
                else if tasklist.name == "Daily TODO" && task.date ?? Date() < Date()
                {
                    lightColorChange = Library.lightredColor
                    colorChange = Library.redColor
                }
                //default
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


struct DefaultTaskView_Previews: PreviewProvider {
    
    struct DefaultTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var showPopUp: Bool = false
        @State var namePopUp: String = ""
        @State var infoPopUp: String = ""
        @State var sortSelection: Int = 0
        @State var inSettings: Bool = false
        @State var tasklist: ListEntity = ListEntity()
        let task: TaskEntity = TaskEntity()
            
            var body: some View {
                DefaultTaskView(vm: self.vm, inSettings: inSettings, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp,  tasklist: $tasklist, task: task )
                
            }
        }
    
    static var previews: some View {
        DefaultTaskViewContainer()
    }
}


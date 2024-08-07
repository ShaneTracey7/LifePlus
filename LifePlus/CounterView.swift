//
//  CounterView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-18.
//

 import SwiftUI
 
struct CounterView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    @State var currentReps: Int = 0
    @State var dummyValue: Int = 0
    @State var optionalTask: TaskEntity?
    
    @Binding var sortSelection: Int
    @Binding var showPopUp: Bool
    @Binding var namePopUp: String
    @Binding var infoPopUp: String
    @Binding var tasklist: ListEntity
    @Binding var taskArr: [TaskEntity]
    @Binding var inCalendar: Bool
    @Binding var editOn: Bool
    
    let task: TaskEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, stepper, and complete and delete buttons
                HStack{
                    
                    //not defaulttask or complete task
                    if !vm.isDefaultTask(task: task) && editOn && !task.isComplete
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
                        
                        
                        Text(task.name ?? "No name")
                            .font(.body)//.font(.title3)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(alignment: .leading)
                            .padding([.leading], 15)
                        
                        Spacer()
                        
                    }
                                        
                    if vm.isDefaultTaskList(tasklist: tasklist)
                    {
                        MyStepper(value: $dummyValue, in:  0...1, inCalendar: $inCalendar)
                        .padding([.trailing], 5)
                    }
                    else if inCalendar
                    {
                        MyStepper(value: $currentReps, in:  0...Int(task.totalReps), inCalendar: $inCalendar)
                            .padding([.trailing], 5)
                            .onChange(of: currentReps) { newValue in
                                
                                vm.setCurrentReps(entity: task, reps: newValue)
                                
                                if newValue == Int(task.totalReps)
                                {
                                    if task.isComplete
                                    {
                                        // do nothing
                                    }
                                    else
                                    {
                                        //reset sorting in tasklistview
                                        sortSelection = 0
                                        
                                        task.isComplete = true
                                        
                                        //change backgroundcolor
                                        lightColorChange = Library.lightgreenColor
                                        colorChange = Library.greenColor
                                        
                                        let result: Int = Int((task.duration * 400) / 60) + 100
                                        let add: Int = result * Int(task.totalReps)
                                        
                                        vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                        vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                        
                                        //for order
                                        vm.addPoints(entity: vm.pointEntities[2], increment: 1)
                                        vm.setTaskCompletedOrder(entity: task, order: Int(vm.pointEntities[2].value))
                                        
                                        //incrementing values within goals
                                        vm.addToCurrentValue(taskIncrement: 1.0, hourIncrement: (Float(Float(task.duration)/60)))
                                        
                                        //check if this completes the list
                                        vm.listCompleteChecker(tasklist: tasklist)
                                        
                                    }
                                }
                                else
                                {
                                    if task.isComplete
                                    {
                                        task.isComplete = false
                                        
                                        //change backgroundcolor
                                        if task.date ??  Date() < Library.firstSecondOfToday()
                                        {
                                            lightColorChange = Library.lightredColor
                                            colorChange = Library.redColor
                                        }
                                        else
                                        {
                                            lightColorChange = Library.lightblueColor
                                            colorChange = Library.blueColor
                                            
                                        }
                                        
                                        vm.adjustPoints(task: task)
                                        
                                        vm.listCompleteChecker(tasklist: tasklist)
                                        
                                    }
                                    else
                                    {
                                        //do nothing
                                    }
                                    
                                    //reset sorting in tasklistview
                                    sortSelection = 0
                                    
                                }
                            }
                    }
                    else
                    {
                        MyStepper(value: $currentReps, in:  0...Int(task.totalReps), inCalendar: $inCalendar)
                            .padding([.trailing], 5)
                            .onChange(of: currentReps) { newValue in
                                
                                vm.setCurrentReps(entity: task, reps: newValue)
                                
                                if newValue == Int(task.totalReps)
                                {
                                    if task.isComplete
                                    {
                                        // do nothing
                                    }
                                    else
                                    {
                                        //reset sorting in tasklistview
                                        sortSelection = 0
                                        
                                        task.isComplete = true
                                        
                                        //change backgroundcolor
                                        lightColorChange = Library.lightgreenColor
                                        colorChange = Library.greenColor
                                        
                                        let result: Int = Int((task.duration * 400) / 60) + 100
                                        let add: Int = result * Int(task.totalReps)
                                        
                                        vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                        vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                        
                                        //for order
                                        vm.addPoints(entity: vm.pointEntities[2], increment: 1)
                                        vm.setTaskCompletedOrder(entity: task, order: Int(vm.pointEntities[2].value))
                                        
                                        //incrementing values within goals
                                        vm.addToCurrentValue(taskIncrement: 1.0, hourIncrement: (Float(Float(task.duration)/60)))
                                        
                                        //check if this completes the list
                                        vm.listCompleteChecker(tasklist: tasklist)
                                        
                                    }
                                }
                                else
                                {
                                    if task.isComplete
                                    {
                                        task.isComplete = false
                                        
                                        //change backgroundcolor
                                        if task.date ??  Date() < Library.firstSecondOfToday()
                                        {
                                            lightColorChange = Library.lightredColor
                                            colorChange = Library.redColor
                                        }
                                        else
                                        {
                                            lightColorChange = Library.lightblueColor
                                            colorChange = Library.blueColor
                                            
                                        }
                                        
                                        vm.adjustPoints(task: task)
                                        
                                        vm.listCompleteChecker(tasklist: tasklist)
                                        
                                    }
                                    else
                                    {
                                        //do nothing
                                    }
                                    
                                    //reset sorting in tasklistview
                                    sortSelection = 0
                                    
                                }
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
                    .frame(width:20, height: 35)
                    .padding([.trailing],vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: tasklist))
                    
                    
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
                        .frame(width: 20, height: 35).frame(alignment: .trailing).padding([.trailing],15).buttonStyle(.plain)
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
                
                
                if !vm.isDefaultTaskList(tasklist: tasklist)
                {
                    
                    if task.isComplete == true {
                        Text("Completed").font(.caption2).foregroundColor(Color.green)
                            .frame(alignment: .leading)
                            .padding([.leading],15)
                            .padding([.top],5)
                        //.border(Color.red)
                    }
                    else if task.date ??  Date() < Library.firstSecondOfToday() && !inCalendar//implement past due
                    {
                        Text("Past Due").font(.caption2).foregroundColor(Color.red)
                            .frame(alignment: .leading)
                            .padding([.leading],15)
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
                
                
                HStack{
                    
                    if vm.isDefaultTaskList(tasklist: tasklist)
                    {
                        Gauge(value: 0, in: 0...1){}.tint(Gradient(colors: [.red, .blue]))
                        Spacer()
                        Text(" 0 / \(task.totalReps)").foregroundColor(Color.white).font(.callout)
                    }
                    else
                    {
                        Gauge(value:  Float(task.currentReps)/Float(task.totalReps),in: 0...1){}.tint(Gradient(colors: [.red, .blue]))
                        Spacer()
                        Text(" \(task.currentReps) / \(task.totalReps)").foregroundColor(Color.white).font(.callout)
                    }
                    
                    
                }.padding([.leading, .trailing], 15)
                
                // contains date and duration
                HStack{
                    if tasklist.name == "Daily DEFAULT" || tasklist.name == "Daily TODO"
                    {
                        Text("Complete by: \((task.date ?? Date()).formatted(date: .omitted, time: .shortened))")
                            .font(.callout) //.font(.body)
                            .foregroundColor(lightColorChange)
                            .frame(alignment: .leading)
                            .padding([.leading],15)
                    }
                    else if !vm.isDefaultTaskList(tasklist: tasklist)
                    {
                        Text("Due: \((task.date ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                            .font(.callout) //.font(.body)
                            .foregroundColor(lightColorChange)
                            .frame(alignment: .leading)
                            .padding([.leading],15)
                    }
                    else
                    {
                       // do nothing
                    }
                    Spacer()
                    
                    if (task.duration > 119)
                    {
                        let quotient = Double (task.duration) / 60
                        Text("\(String(format: "%.1f", quotient)) hours")
                            .font(.callout) //.font(.body)
                        //.padding([.trailing],10)
                            .foregroundColor(lightColorChange)
                            .frame(width: 100)
                    }
                    else
                    {
                        Text("\(task.duration) mins").font(.callout) //.font(.body)
                        //.padding([.trailing],10)
                            .foregroundColor(lightColorChange).frame(width: 100)
                    }
                    
                    
                }
                //.padding([.top, .bottom], 5)
                //.border(Color.red)
                
            }/*.frame(width: 350)*/.frame(maxWidth: .infinity)
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
            
            currentReps = Int(task.currentReps)
            
            if !vm.isDefaultTaskList(tasklist: tasklist)
            {
                let td = Library.firstSecondOfToday()
                
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
                //past due
                else if task.date ?? Date() < td || tasklist.name == "Daily TODO" && task.date ?? Date() < Date()
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
 
 struct CounterView_Previews: PreviewProvider {
 
 struct CounterViewContainer: View {
 @State var vm = CoreDataViewModel()
 @State var sortSelection: Int = 0
 @State var showPopUp: Bool = false
 @State var namePopUp: String = ""
 @State var infoPopUp: String = ""
 @State var totalReps: Int = 0
 @State var tasklist: ListEntity = ListEntity()
 @State var taskArr: [TaskEntity] = []
 @State var inCalendar: Bool = false
 @State var editOn: Bool =  false
 
 let task: TaskEntity = TaskEntity()
 
 var body: some View {
     CounterView(vm: self.vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, tasklist: $tasklist, taskArr: $taskArr, inCalendar: $inCalendar, editOn: $editOn, task: task)
 
 }
 }
 
 static var previews: some View {
 CounterViewContainer()
 }
 }
 
 
 

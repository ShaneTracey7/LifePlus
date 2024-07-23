//
//  StepCView.swift
//  LifePlus
//
//  Created by Coding on 2024-07-22.
//
import SwiftUI

struct StepCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    @State var optionalTask: TaskEntity?
    
    
    @Binding var sortSelection: Int
    @Binding var showPopUp: Bool
    @Binding var namePopUp: String
    @Binding var infoPopUp: String
    @Binding var steplist: ListEntity
    @Binding var taskArr: [TaskEntity]
    @Binding var inCalendar: Bool
    @Binding var editOn: Bool
    
    let task: TaskEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                //contains name, and complete and delete buttons
                HStack{
                                    
                    //edit is on and step isn't complete
                if editOn && !task.isComplete
                {
                        NavigationLink(destination: AddHybridTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $steplist, task: $optionalTask)){

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
                               // vm.addToCurrentValue(taskIncrement: 1.0, hourIncrement: (Float(Float(task.duration)/60)))
                                
                                //check if this completes the list
                                vm.listCompleteChecker(tasklist: steplist)
                                
                            } label: {
                                Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Library.lightgreenColor)
                            }
                            .frame(width: 20, height: 35)
                            .frame(alignment: .trailing).buttonStyle(.plain)
                            .padding([.trailing],5)
                            
                        }
                        else{
                            
                            //undo button
                            Button {
                                print("undo button was pressed")
                                withAnimation {
                                    //task.isComplete.toggle() //idk what this does
                                }
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                task.isComplete = false
                                
                                //change backgroundcolor (may have to take in consideration if task is past due (would be red)
                                let td = Library.firstSecondOfToday()
                                
                                if task.date ?? Date() < td || steplist.name == "Daily TODO" && task.date ?? Date() < Date()
                                {
                                    lightColorChange = Library.lightredColor
                                    colorChange = Library.redColor
                                }
                                else
                                {
                                    lightColorChange = Library.lightblueColor
                                    colorChange = Library.blueColor
                                }
                                
                                
                                let subtract: Int = (Int((task.duration * 400) / 60) + 100)*(-1)
                                
                                vm.addPoints(entity: vm.pointEntities[0], increment: subtract)
                                vm.addPoints(entity: vm.pointEntities[1], increment: subtract)
                                
                                //for order (might be tricky to implement) i think i just get rid of it
                                //vm.setTaskCompletedOrder(entity: task, order: Int(vm.pointEntities[2].value))
                                
                                //decrementing values within goals
                                //vm.adjustGoals(task: task)
                                
                                //sets list as incomplete
                                vm.listNotCompleteCalendar(tasklist: steplist)
                                
                            } label: {
                                Image(systemName: "arrow.uturn.right.circle").imageScale(.medium).foregroundColor(Color.blue)
                            }
                            .frame(width: 20, height: 35)
                            .frame(alignment: .trailing).buttonStyle(.plain)
                            .padding([.trailing],5)
                            
                            //Spacer(minLength: 40).frame(alignment: .trailing)
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
                    .padding([.trailing],vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: steplist))
                    

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
                                let calendarIndex = vm.findCalendarListIndex(tasklist: steplist)
                                vm.listCompleteChecker(tasklist: vm.calendarListEntities[calendarIndex])
                            }
                            else
                            {
                                vm.listCompleteChecker(tasklist: steplist)
                            }
                            print("confirmation delete button was pressed")
                        }
                        Button("No", role: .cancel){}
                        
                    }
                
                    
            }.padding([.trailing], 5)
            //.border(Color.red)
                
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
                
            // contains date and duration
            HStack{
                
                Text("Due: \((task.date ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                        .font(.callout) //.font(.body)
                        .foregroundColor(lightColorChange)
                        .frame(alignment: .leading)
                        .padding([.leading],15)

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
            
                let td = Library.firstSecondOfToday()
                
                //complete
                if task.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
                }
                //past due
                else if task.date ?? Date() < td
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
    }
}


struct StepCView_Previews: PreviewProvider {
    
    struct StepCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var showPopUp: Bool = false
        @State var namePopUp: String = ""
        @State var infoPopUp: String = ""
        @State var steplist: ListEntity = ListEntity()
        @State var taskArr: [TaskEntity] = []
        @State var inCalendar: Bool =  false
        @State var editOn: Bool =  false
        let task: TaskEntity = TaskEntity()
            
            var body: some View {
                StepCView(vm: self.vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, steplist: $steplist, taskArr: $taskArr, inCalendar: $inCalendar, editOn: $editOn, task: task)
                
            }
        }
    
    static var previews: some View {
        StepCViewContainer()
    }
}

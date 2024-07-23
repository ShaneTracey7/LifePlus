//
//  AddStepView.swift
//  LifePlus
//
//  Created by Coding on 2024-07-23.
//

import SwiftUI

struct AddStepView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var goal: GoalEntity
    @Binding var step: TaskEntity? //needed for task editing
    
    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var stepName: String = ""
    @State private var stepInfo: String = ""//Enter text here ..."
    @State private var startDate = Date()
    @State private var endDate = Date()
   @State private var duration: Int = 0
    let mins: [Int] = [5,15,30,60,90,120,180]
    @State private var type: String = ""
    let types: [String] = ["basic", "task", "counter"]
    
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{
                        
                        Section("Item Details"){
                            
                            //name of item
                            VStack{
                                                                              
                                if errorMsg == "Item successfully added!" || errorMsg == "No changes were made" || errorMsg == "Item successfully updated!"
                                {
                                    if changeColor
                                    {
                                        Text(errorMsg).foregroundColor(Color.green).font(.caption)
                                    }
                                    else
                                    {
                                        Text(errorMsg).foregroundColor(Color.blue).font(.caption)
                                    }
                                    
                                }
                                
                                HStack{
                                    Text("Name of Item")
                                        .font(.title2)
                                        .foregroundColor(Color.secondary)
                                    Spacer()
                                }
                                
                                
                                if errorMsg == "* Too many characters!" || errorMsg == "* This field can't be empty!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                TextField("", text: $taskName)
                                    .font(.title3)
                                    .foregroundColor(Color.primary).frame(height: 30)
                            }
                            
                            // item style
                            VStack{
                                
                                if errorMsg == "* You must select an item style!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                Picker(selection: $type, label: Text("Type").foregroundColor(Color.secondary).font(.title3))
                                {
                                    Text("\("")").tag("")
                                    ForEach(types, id: \.self) { t in
                                        Text("\(t)").tag(t)
                                    }
                                }
                                .frame(height: 40)
                            }
                            
                            
                            if type == "task" || type == "counter"
                            {
                                // item description
                                VStack
                                {
                                    HStack{
                                        Text("Item Description")
                                            .font(.title2)
                                            .foregroundColor(Color.secondary)
                                        Spacer()
                                    }
                                    
                                    if errorMsg == "* Too many characters in description!"
                                    {
                                        Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                    }
                                    
                                    TextEditor(text: $taskInfo)
                                        .frame(height: 135)
                                        .font(.body)
                                        .foregroundStyle(Color.primary)
                                        .border(Color.secondary)
                                    
                                }
                                
                                // item duration
                                VStack{
                                    
                                    if errorMsg == "* Duration must be at least 5 mins!"
                                    {
                                        Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                    }
                                    
                                    HStack{
                                        
                                        Picker(selection: $duration, label: Text("Duration").foregroundColor(Color.secondary).font(.title3))
                                        {
                                            Text("\(0)").tag(0)
                                            ForEach(mins, id: \.self) { min in
                                                Text("\(min)").tag(min)
                                            }
                                        }
                                        .frame(height: 40)
                                        
                                        Text("mins").foregroundColor(Color.secondary).font(.body)
                                    }
                                    
                                }
                                
                            }
                            
                            if type == "counter"
                            {
                                VStack{
                                    
                                    if errorMsg == "* There must be at least 2 but less than 21!" || errorMsg == "* Repetitions must be greater than the current amount!"
                                    {
                                        Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                    }
                                    
                                    HStack{
                                        
                                        Picker(selection: $totalReps, label: Text("Repetitions").foregroundColor(Color.secondary).font(.title3))
                                        {
                                            Text("\(0)").tag(0)
                                            ForEach(reps, id: \.self) { r in
                                                Text("\(r)").tag(r)
                                            }.foregroundColor(Color.primary)
                                        }
                                        .frame(height: 40)
                                        
                                        Text("reps").foregroundColor(Color.secondary).font(.body)
                                    }
                                }
                            }
                            
                            if type == "task" || type == "counter"
                            {
                                    VStack{
                                        
                                        if errorMsg == "* You cannot select a date from the past!"
                                        {
                                            Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                        }
                                        
                                        VStack{
                                            DatePicker(
                                                "Due Date",
                                                selection: $date,
                                                in: Library.getDate(tasklist: tasklist)[0]...Library.getDate(tasklist: tasklist)[1],
                                                displayedComponents: [.date]
                                            )
                                            .frame(height: 60)
                                            .foregroundColor(Color.secondary)
                                            .font(.title3)
                                        }
                                    }
                                
                            }
                            
                        }
                        
                    }
                    .scrollDisabled(true)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    
                    
                    if task == nil{
                    
                    // add task button
                    Button(action: {
                        
                        if validateForm(){
                            

                                vm.listNotComplete(tasklist: tasklist)
                            
                            
                            //vm.listNotComplete(tasklist: tasklist)
                            
                            vm.addStep(goalId: goal.id, name: stepName, info: stepInfo, duration: duration, startDate: startDate, endDate: endDate)
                            
                            //add to currentValue of Goals
                            
                            print("step has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of step")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Item").font(.body)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .buttonStyle(PressableButtonStyle())
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    }
                     else
                     {
                     // update step button
                         Button(action: {
                             
                             //task changed
                             
                             if validateForm(){
                                 if !vm.taskChangeH(task: task!,name: taskName, duration: duration, date: date, info: taskInfo, totalReps: totalReps, type: type)
                                 {
                                     errorMsg = "No changes were made"
                                     print("no changes made")
                                 }
                                 else
                                 {
                                 //maybe delete task and add with updated variables to make it easier
                                 //reset sorting in tasklistview
                                 
                                 
                                     if type == "basic"
                                     {
                                         duration = 0
                                         taskInfo = ""
                                         totalReps = 1
                                         task?.currentReps = 0
                                         date = tasklist.endDate ?? Date()
                                     }
                                     else if type == "task"
                                     {
                                         totalReps = 1
                                         task?.currentReps = 0
                                     }
                                     else // "counter
                                     {
                                         //do nothing
                                     }
                                 vm.updateTask(task: task!, name: taskName, duration: duration, date: date, info: taskInfo, totalReps: totalReps)
                                 
                                 errorMsg = "Item successfully updated!"
                                 print("task has been updated")
                                 }
                            }
                            else
                             {
                                print("Incorrect input to update task")
                             }
                     
                     }, label: {
                     VStack{
                     
                     Image(systemName: "plus.app").font(.title)
                     Text("Update").font(.body)
                     }.frame(maxWidth: .infinity, maxHeight: .infinity)
                     })
                     .buttonStyle(PressableButtonStyle())
                     .frame(width:150, height: 75)
                     .background(Color.blue)
                     .cornerRadius(25)
                     .foregroundColor(Color.white)
                     }
                    
                    //Spacer().frame(maxHeight: 40)
                    
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .background(Color(light: Library.customBlue2, dark: Library.customGray2))
            }
            
        }
        .scrollContentBackground(.hidden)
        //moved graident from here
   
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear{
                
                if task != nil{
                    
                    taskName = task?.name ?? "error"
                    
                    if task?.duration == Int32(0) //is a basic task
                    {
                        type = "basic"
                        taskInfo = ""
                        totalReps = 1
                        duration = 0
                        date = tasklist.endDate ?? Date()
                    }
                    else
                    {
                        taskInfo = task?.info ?? "error"
                        duration = Int(task?.duration ?? 0)
                        date = task?.date ?? Date()
                        
                        if task?.totalReps == Int32(1) //is a task
                        {
                            type = "task"
                        }
                        else //is a counter task
                        {
                            type = "counter"
                            totalReps = Int(task?.totalReps ?? 2)
                        }
                    }
                    
                    
                }
            }

    }
    
    func validateForm() -> Bool {
        
        let yesterday = Date.now.addingTimeInterval(-86400)
        
        let str = taskName
        let str2 = taskName
        let smallCharCount: Float = str.reduce(0) {
            $1 == "l" || $1 == "." || $1 == "," || $1 == " " || $1 == "i" || $1 == "t" || $1 == "f" || $1 == "j" || $1 == "'" ? $0 + 1 : $0 }
        let largeCharCount: Float = str2.reduce(0) {
            $1 == "w" || $1 == "m" || $1.isUppercase  ? $0 + 1 : $0 }
        
        let tally: Float = Float((taskName.count)*2) - (smallCharCount) + (largeCharCount)
        
        print("smallCharCount: \(smallCharCount) largeCharCount: \(largeCharCount)")
        
        print("\((taskName.count)*2) - \(smallCharCount) + \(largeCharCount)")
        
        if taskName.isEmpty
        {
            errorMsg = "* This field can't be empty!"
            print("Error 1")
            return false
        }
        else if tasklist.style != "default" && (Int(tally) > 57 || Int(tally) > 51 && type == "task" || Int(tally) > 43 && type == "counter")
        {
          errorMsg = "* Too many characters!"
          print("Error 2.1")
          return false
        }
        else if tasklist.style == "default" && (Int(tally) > 65 || Int(tally) > 57 && type == "task" || Int(tally) > 43 && type == "counter")
        {
          errorMsg = "* Too many characters!"
          print("Error 2.2")
          return false
        }
        else if type == ""
        {
            errorMsg = "* You must select an item style!"
            print("Error 3")
            return false
        }
        else if type == "task" || type == "counter"
        {
            //task info character count check
            if taskInfo.count > 150
            {
                errorMsg = "* Too many characters in description!"
                print("Error 4")
                return false
            }
            else if duration == 0
            {
                errorMsg = "* Duration must be at least 5 mins!"
                print("Error 5")
                return false
            }
            else if type == "counter" && totalReps < 2 || totalReps > 20
            {
                errorMsg = "* There must be at least 2 but less than 21!"
                print("Error 6")
                return false
            }
            else if date < yesterday
            {
                errorMsg = "* You cannot select a date from the past!"
                print("Error 7")
                return false
            }
            else if type == "counter" && task != nil && task!.currentReps >= totalReps
            {
                errorMsg = "* Repetitions must be greater than the current amount!"
                print("Error 8")
                return false
            }
            else if taskInfo.isEmpty
            {
                
                if type == "task"
                {
                    print("Good 1.1")
                    totalReps = 1
                }
                
                if(task != nil)
                {
                    changeColor.toggle()
                    return true
                }
                else
                {
                    taskInfo = "No item description"
                    changeColor.toggle()
                    errorMsg = "Item successfully added!"
                    return true
                }
            }
            else
            {
                
                if type == "task"
                {
                    print("Good 2.1")
                    totalReps = 1
                }
                
                if( task != nil)
                {
                    changeColor.toggle()
                    return true
                }
                else
                {
                    changeColor.toggle()
                    errorMsg = "Item successfully added!"
                    return true
                }
            }
            
        }
        else
        {   //basic item
            
            if( task != nil)
            {
                print("Good 3.1")
                changeColor.toggle()
                return true
            }
            else
            {
                print("Good 3.2")
                changeColor.toggle()
                errorMsg = "Item successfully added!"
                taskInfo = ""
                totalReps = 1
                duration = 0
                date = tasklist.endDate ?? Date()
                return true
            }
        }
      }
                
}

struct AddStepView_Previews: PreviewProvider {
    struct AddStepViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var goal = GoalEntity()
        @State var step: StepEntity? = nil
            var body: some View {
                AddStepView(vm: self.vm, goal: goal, step: $step) /**/
            }
        }
    
    static var previews: some View {
        AddStepViewContainer()
    }
}

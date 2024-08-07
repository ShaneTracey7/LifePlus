//
//  AddTaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-18.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var sortSelection: Int
    @Binding var tasklist: ListEntity
    @Binding var task: TaskEntity? //needed for task editing
    
    
    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var taskName: String = ""
    @State private var taskInfo: String = ""//Enter text here ..."
    @State private var date = Date()
   @State private var duration: Int = 0
    let mins = [5,15,30,60,90,120,180]
    
    
    
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("Task Details"){
                            
                            VStack{
                                
                                if errorMsg == "Task successfully added!" || errorMsg == "No changes were made" || errorMsg == "Item successfully updated!"
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
                                    Text("Name of Task")
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
                                        .foregroundColor(Color.primary)
                                        .frame(height: 30)
                            }
                            
                            VStack
                            {
                                HStack{
                                    Text("Task Description")
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
                                            Text("\(min)")          .tag(min)
                                        }
                                }
                                        .frame(height: 40)
                                
                                Text("mins").foregroundColor(Color.secondary).font(.body)
                                }
                            }
                            
                            VStack{
                                
                                if errorMsg == "* You cannot select a date from the past!"
                                    {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
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
                    .scrollDisabled(true)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    if task == nil{
                        
                        //add task button
                        Button(action: {
                            
                            if validateForm(){
                                
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                vm.addTask(name: taskName, duration: duration, date: date, isComplete: false, info: taskInfo, listId: tasklist.id ?? UUID(), totalReps: 1, currentReps: 0)
                                
                                vm.listNotComplete(tasklist: tasklist)
                                
                                //add to currentValue of Goals
                                
                                print("task has been added")
                            }
                            else
                            {
                                print("Incorrect input for task")
                            }
                            
                            
                        }, label: {
                            VStack{
                                
                                Image(systemName: "plus.app").font(.title)
                                Text("Add Task").font(.body)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        })
                        .buttonStyle(PressableButtonStyle())
                        .frame(width:150, height: 75)
                        .background(Color.green)
                        .cornerRadius(25)
                        .foregroundColor(Color.white)
                        
                        //Spacer().frame(maxHeight: 40)
                    }
                    else
                    {
                        //update task button
                        Button(action: {
                            
                            //task changed
                            
                            if validateForm(){
                                if !vm.taskChangeT(task: task!,name: taskName, duration: duration, date: date, info: taskInfo)
                                {
                                    errorMsg = "No changes were made"
                                    print("no changes made")
                                }
                                else
                                {
                                //maybe delete task and add with updated variables to make it easier
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                vm.updateTask(task: task!, name: taskName, duration: duration, date: date, info: taskInfo, totalReps: 1)
                                
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
                        taskInfo = task?.info ?? "error"
                        duration = Int(task?.duration ?? 0)
                        date = task?.date ?? Date()
                            
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
        
        if taskName.isEmpty
        {
            errorMsg = "* This field can't be empty!"
            return false
        }
        else if Int(tally) > 51//42
        {
          errorMsg = "* Too many characters!"
          return false
        }
        //task info character count check
        else if taskInfo.count > 150
        {
            errorMsg = "* Too many characters in description!"
            return false
        }
        else if duration == 0
        {
            errorMsg = "* Duration must be at least 5 mins!"
            return false
        }
        else if date < yesterday
        {
            errorMsg = "* You cannot select a date from the past!"
            return false
        }
        else if taskInfo.isEmpty
        {
            if(task != nil)
            {
                changeColor.toggle()
                errorMsg = "Item successfully updated!"
                return true
            }
            else
            {
                taskInfo = "No task description"
                changeColor.toggle()
                errorMsg = "Task successfully added!"
                return true
            }
            
        }
        else
        {
            if(task != nil)
            {
                changeColor.toggle()
                errorMsg = "Item successfully updated!"
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
                
}

struct AddTaskView_Previews: PreviewProvider {
    struct AddTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var tasklist = ListEntity()
        @State var task: TaskEntity? = nil
            var body: some View {
                AddTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist, task: $task)
            }
        }
    
    static var previews: some View {
        AddTaskViewContainer()
    }
}


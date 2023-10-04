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
    
    @State var errorMsg: String = ""
    
    @State private var taskName: String = ""
    @State private var date = Date()
   @State private var duration: Int = 0
    let mins = [5,15,30,60,90,120,180]
    
    
    
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("Task Description"){
                            
                            VStack{
                            
                            if errorMsg == "* Too many characters!" || errorMsg == "* This field can't be empty!"
                                {
                                Text(errorMsg).foregroundColor(Color.red).font(.caption)
                            }
                            if errorMsg == "Task successfully added!"
                                {
                                Text(errorMsg).foregroundColor(Color.green).font(.caption)
                            }
                            
                            TextField("Name of Task", text: $taskName)
                                .font(.title2)
                                .padding([.top], 25)
                                .foregroundColor(Color.primary)
                            }
                            
                            VStack{
                                
                                if errorMsg == "* Duration must be at least 5 mins!"
                                    {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                Picker(selection: $duration, label: Text("Duration"))
                                {
                                    Text("\(0)").tag(0)
                                    ForEach(mins, id: \.self) { min in
                                        Text("\(min)").tag(min)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 150)
                            }
                            
                            VStack{
                                
                                if errorMsg == "* You cannot select a date from the past!"
                                    {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                DatePicker(
                                    "Due Date",
                                    selection: $date,
                                    displayedComponents: [.date]
                                )
                                .frame(height: 75)
                                .foregroundColor(Color.primary)
                                
                            }
                        }
                        .frame(width: 300)
                        
                        
                    }
                    .padding([.top], 75)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    Button(action: {
                        
                        if validateForm(){
                            
                            //reset sorting in tasklistview
                            sortSelection = 0
                            
                            vm.addTask(name: taskName, duration: duration, date: date, isComplete: false)
                            
                            //add to currentValue of Goals
                            
                            print("task has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of task")
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
                    
                    Spacer().frame(maxHeight: 40)
                
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                    .background(Color(light: Library.customBlue2, dark: Library.customGray2))
            }
            
        }
        .scrollContentBackground(.hidden)
        //moved graident from here
            
            .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)

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
            return false
        }
        else if Int(tally) > 42
        {
          errorMsg = "* Too many characters!"
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
        errorMsg = "Task successfully added!"
        return true
      }
                
}

struct AddTaskView_Previews: PreviewProvider {
    struct AddTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
            var body: some View {
                AddTaskView(vm: self.vm, sortSelection: $sortSelection)
            }
        }
    
    static var previews: some View {
        AddTaskViewContainer()
    }
}
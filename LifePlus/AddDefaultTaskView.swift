//
//  AddDefaultTaskView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-17.
//

import SwiftUI

struct AddDefaultTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var tasklist: ListEntity
    
    
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
                                
                                if errorMsg == "Task successfully added!"
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
                                
                                Picker(selection: $duration, label: Text("Duration"))
                                {
                                    Text("\(0)").tag(0)
                                    ForEach(mins, id: \.self) { min in
                                        Text("\(min)").tag(min)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                            }
                            
                            if tasklist.name == "Daily DEFAULT"
                            {
                                VStack{
                                    
                                    DatePicker(
                                        "Complete by: ",
                                        selection: $date,
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    .frame(height: 75)
                                    .foregroundColor(Color.primary)
                                }
                            }
                        }
                        .frame(width: 300)
                        
                        
                    }
                    .scrollDisabled(true)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    Button(action: {
                        
                        if validateForm(){
                            
                            vm.addTask(name: taskName, duration: duration, date: date, isComplete: false, info: taskInfo, listId: tasklist.id ?? UUID())
                            
                            print("task has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of task")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Default").font(.body)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .buttonStyle(PressableButtonStyle())
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    
                    //Spacer().frame(maxHeight: 40)
                
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
        //task info character count check
        else if taskInfo.count > 150
        {
            errorMsg = "* Too many characters in description!"
            return false
        }
        else if taskInfo.isEmpty
        {
            taskInfo = "No task description"
        }
        else if duration == 0
        {
            errorMsg = "* Duration must be at least 5 mins!"
            return false
        }
        
        changeColor.toggle()
        errorMsg = "Task successfully added!"
        return true
      }
                
}

struct AddDefaultTaskView_Previews: PreviewProvider {
    struct AddDefaultTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var tasklist = ListEntity()
            var body: some View {
                AddDefaultTaskView(vm: self.vm, tasklist: $tasklist)
            }
        }
    
    static var previews: some View {
        AddDefaultTaskViewContainer()
    }
}


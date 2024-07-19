//
//  AddBasicTask.swift
//  LifePlus
//
//  Created by Coding on 2023-10-16.
//

import SwiftUI

//basic tasks do not adjust any points

struct AddBasicTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var tasklist: ListEntity
    @Binding var task: TaskEntity? //needed for task editing

    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var taskName: String = ""
    
    
    
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("Item Details"){
                            
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
                                        .foregroundColor(Color.primary)
                                
                                    Divider()
                            }
                        }
                        .frame(width: 300)
                        
                    }
                    .scrollDisabled(true)
                    .padding([.top], 100)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    if task == nil{
                        
                        //add task button
                        Button(action: {
                            
                            if validateForm(){
                                
                                vm.addTask(name: taskName, duration: 0, date: tasklist.endDate ?? Date(), isComplete: false, info: "", listId: tasklist.id ?? UUID(), totalReps: 1, currentReps: 0)
                                
                                vm.listNotComplete(tasklist: tasklist)
                                
                                //add to currentValue of Goals
                                
                                print("item has been added")
                            }
                            else
                            {
                                print("Incorrect input for name of item")
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
                        .padding([.bottom], 200)
                        
                    }
                    else
                    {
                        //update task button
                        Button(action: {
    
                            if validateForm(){
                                //task changed
                                if task!.name == taskName
                                {
                                    errorMsg = "No changes were made"
                                    print("no changes made")
                                }
                                else
                                {
                                    vm.updateBasicTask(task: task!, name: taskName)
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
                    }
                        
             }

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
        else if Int(tally) > 57
        {
            errorMsg = "* Too many characters!"
            return false
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

struct AddBasicTaskView_Previews: PreviewProvider {
    struct AddBasicTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var tasklist = ListEntity()
        @State var task: TaskEntity? = nil
            var body: some View {
                AddBasicTaskView(vm: self.vm, tasklist: $tasklist, task: $task)
            }
        }
    
    static var previews: some View {
        AddBasicTaskViewContainer()
    }
}

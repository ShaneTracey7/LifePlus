//
//  AddTaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-18.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var vm: CoreDataViewModel
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

                            TextField("Name of Task", text: $taskName)
                                .frame(width:300)
                                .font(.title2)
                                .cornerRadius(25)
                                .padding([.top], 25)
                                .foregroundColor(Color.white)
                            
                            Picker(selection: $duration, label: Text("Duration"))
                            {
                                Text("\(0)").tag(0)
                                ForEach(mins, id: \.self) { min in
                                    Text("\(min)").tag(min)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            DatePicker(
                                "Due Date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .frame(width:300, height: 75)
                            .foregroundColor(Color.white)
                        }
                    
                    }
                    .padding([.top], 75)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom)).foregroundColor(Color.black)
                    
                    Button(action: {
                        vm.addTask(name: taskName, duration: duration, date: date, isComplete: false)
                        print("task has been added")
                    })
                    {
                        
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Task").font(.body)
                        }
                        
                    }.buttonStyle(.plain)
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    
                }.scrollContentBackground(.hidden)
                    .background(Color(red: 0.50, green: 0.70, blue: 1))
                
            }
            
        }
        .scrollContentBackground(.hidden)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom))

    }
                
}

struct AddTaskView_Previews: PreviewProvider {
    struct AddTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                AddTaskView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        AddTaskViewContainer()
    }
}

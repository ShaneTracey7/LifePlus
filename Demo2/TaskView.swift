//
//  TaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    @Binding var tasks: [Task]
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .center){
                
                HStack(){
                    
                    Text(task.name)
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding([.trailing], 50)
                    
                    //task complete button
                    Button {
                        print("complete button was pressed")
                    } label: {
                        Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Color.green)
                    }.frame(width: 40, height: 40)
                    
                    //delete task button
                    Button {
                        if let index = tasks.firstIndex (of: task)
                        {
                            tasks.remove(at: index)
                            print("delete button was pressed")
                        }
                    } label: {
                        Image(systemName: "trash").imageScale(.medium).foregroundColor(Color.red)
                    }.frame(width: 40, height: 40)
                    
                }
                .padding([.top, .bottom], 5)
                
                HStack(spacing: 70){
                    
                    Text("Due: \(task.due.formatted(date: .abbreviated, time: .omitted))")
                        .font(.body)
                        .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    
                    if (task.duration > 119)
                    {
                        let quotient = Double (task.duration) / 60
                        Text("\(String(format: "%.1f", quotient)) hours")
                            .font(.body)
                            .padding([.trailing],40)
                            .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    }
                    else
                    {
                        Text("\(task.duration) mins").font(.body)
                            .padding([.trailing],40).foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    }
                    
                }
                .padding([.top, .bottom], 5)
                
            }
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 50)
                }
                
                .foregroundColor(Color(red: 0.65, green: 0.75, blue: 0.95))
                .frame(width:350)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
        
        }.frame(width: 410.0)
    }
}

struct TaskView_Previews: PreviewProvider {
    
    struct TaskViewContainer: View {
        @State var task: Task = Task(name: "Mow the Lawn",
                                     duration: 60,
                                     due : Date())
        @State var tasks = [
            Task(name: "Mow the Lawn",
                 duration: 60,
                 due : Date()),
            Task(name: "Take out garbage",
                 duration: 150,
                 due : Date()),
            Task(name: "Walk the dog",
                 duration: 20,
                 due : Date())
        ]
            var body: some View {
                TaskView(task: self.task, tasks: self.$tasks)
            }
        }
    
    static var previews: some View {
        TaskViewContainer()
    }
}


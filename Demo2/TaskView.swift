//
//  TaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskView: View {
   // @State var task: Task
    @Binding var points: Int
    @Binding var rewardPoints: Int
    //@Binding var tasks: [Task]
    @State var task: TaskEntity
    @State var tasks: [TaskEntity]
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading){
                
                HStack{
                    
                    Text(task.name ?? "No name")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width:225, alignment: .leading)
                        .padding([.leading], 20)
                    
                    if let index = tasks.firstIndex (of: task)
                    {
                    
                        if tasks[index].isComplete == false {
                        
                            //task complete button
                            Button {
                                print("complete button was pressed")
                                withAnimation {
                                    task.isComplete.toggle()
                                }
                                tasks[index].isComplete = true
                                let add: Int = Int((tasks[index].duration * 400) / 60) + 100
                                points += add
                                rewardPoints += add
                            
                            } label: {
                                Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Color.green)
                              }
                              .frame(width: 40, height: 40)
                              .frame(alignment: .trailing).buttonStyle(.plain)
                        
                            //delete task button
                            Button {
                                    withAnimation{
                                        tasks.remove(at: index)
                                        print("delete button was pressed")
                                    }
                            } label: {
                                Image(systemName: "trash").imageScale(.medium).foregroundColor(Color.red)
                              }.frame(width: 40, height: 40).frame(alignment: .trailing).padding([.trailing],10).buttonStyle(.plain)

                        
                        }
                        else{
                            Text("Completed").font(.caption).foregroundColor(Color(red: 0.30, green: 0.60, blue: 0.40))
                                .frame(alignment: .trailing)
                        
                        }
                    
                    
                    
                    }
                }.padding([.top, .bottom], 5)
                    //.border(Color.red)
                    

               // HStack(spacing: 70){
                HStack{
                    Text("Due: \((task.date ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                        .font(.body)
                        .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                        .frame(width: 225, alignment: .leading)
                        .padding([.leading],20)
                        
                    
                    if (task.duration > 119)
                    {
                        let quotient = Double (task.duration) / 60
                        Text("\(String(format: "%.1f", quotient)) hours")
                            .font(.body)
                            .padding([.trailing],10)
                            .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                            .frame(width: 100)
                    }
                    else
                    {
                        Text("\(task.duration) mins").font(.body)
                            .padding([.trailing],10)
                            .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14)).frame(width: 100)
                    }
                    
                }
                .padding([.top, .bottom], 5)
                //.border(Color.red)
                
                
                
            }.frame(width:350)//.border(Color.green)
                
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 50)
                }
                
                .foregroundColor(Color(red: 0.65, green: 0.75, blue: 0.95))
                
                
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
        
        }.frame(width: 410.0)//.border(Color.blue)
    }
}

struct TaskView_Previews: PreviewProvider {
    
    struct TaskViewContainer: View {
        @State var points: Int = 0
        @State var rewardPoints: Int = 0
        @State var task: Task = Task(name: "Mow the Lawn",
                                     duration: 60,
                                     due : Date(),isComplete: false)
        @State var tasks = [
            Task(name: "Mow the Lawn",
                 duration: 60,
                 due : Date(),isComplete: false),
            Task(name: "Take out garbage",
                 duration: 150,
                 due : Date(),isComplete: false),
            Task(name: "Walk the dog",
                 duration: 20,
                 due : Date(),isComplete: false)
        ]
            var body: some View {
                TaskView(points: self.$points, rewardPoints: self.$rewardPoints, task: task, tasks: tasks)
                //TaskView(points: self.$points, rewardPoints: self.$rewardPoints, tasks: self.$tasks, task: self.task)
            }
        }
    
    static var previews: some View {
        TaskViewContainer()
    }
}


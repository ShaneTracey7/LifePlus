//
//  TaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    var body: some View {
        
            VStack(alignment: .center){
                
                HStack(){
                   
                    Text(task.name)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding([.trailing], 50)
                    Button {
                        print("complete button was pressed")
                    } label: {
                        Image(systemName: "checkmark.circle").imageScale(.large).foregroundColor(Color.green)
                    }.frame(width: 40, height: 40)
                    Button {
                        print("delete button was pressed")
                    } label: {
                        Image(systemName: "trash").imageScale(.large).foregroundColor(Color.red)
                    }.frame(width: 40, height: 40)
                    
                }
                .padding([.top, .bottom], 10)
                
                HStack(spacing: 70){
                    
                    Text("Due: \(task.due.formatted(date: .abbreviated, time: .omitted))")
                        .font(.body)
                        .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    
                    if (task.duration > 119)
                    {
                        let quotient = Double (task.duration) / 60
                        Text("\(String(format: "%.1f", quotient)) hours")
                            .font(.body)
                            .padding([.trailing],60)
                            .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    }
                    else
                    {
                        Text("\(task.duration) mins").font(.body)
                            .padding([.trailing],60).foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                        
                    }
                    
                }
                .padding([.top, .bottom], 10)
                
            }
            .frame(width: 410.0)
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 50)
                }
                .foregroundColor(Color(red: 0.65, green: 0.75, blue: 0.95))
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(
              color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
              )
    }
}

struct TaskView_Previews: PreviewProvider {
    static var task = Task.sampleData[1]
    static var previews: some View {
        TaskView(task:task)
                    
    }
}

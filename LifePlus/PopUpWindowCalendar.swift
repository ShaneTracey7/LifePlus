//
//  PopUpWindowCalendar.swift
//  LifePlus
//
//  Created by Coding on 2023-10-30.
//

import SwiftUI

struct PopUpWindowCalendar: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var title: String
    var buttonText: String
    @State var taskCompletedValue: Float = 0
    @Binding var list: ListEntity
    @Binding var show: Bool
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0 : 0).edgesIgnoringSafeArea(.all)
                // PopUp Window
                
                Rectangle()//.frame(maxWidth: 300, maxHeight: 300)
                    .frame(width: 350, height: 520)
                    .foregroundColor(Color(light: Color.blue, dark: Color.secondary))
                    .frame(alignment: .center).cornerRadius(25)
                    
                
                VStack(alignment: .center, spacing: 0) {
                    
                    HStack{
                        Text(title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30, alignment: .center)
                            .font(.title)
                            .foregroundColor(Color(light: Color.blue, dark: Color.secondary))
                            //.background(Color.primary.colorInvert())
                            .padding([.top, .bottom],10)
                        
                        if list.name != "testing123"
                        {
                            VStack{
                                Gauge(value: taskCompletedValue , in: 0...1){
                                } currentValueLabel: {
                                    HStack(spacing: 0){
                                        Text("\(Int(taskCompletedValue * 100))")
                                            .font(.body)
                                        Text("%").font(.caption)
                                        // Image(systemName: "percent").font(.caption2)
                                    }.foregroundColor(Color(light: Color.blue, dark: Color.white))
                                }
                                .tint(Gradient(colors: [.red, .green])).gaugeStyle(.accessoryCircular)
                                .frame(height: 30)
                                //.background(Color.primary.colorInvert())
                                .padding([.top], 30)
                                
                                Text("Completed").foregroundColor(Color(light: Color.blue, dark: Color.white)).font(.caption)
                                Spacer()
                                
                            }.frame(width:100, height: 80)
                               // .background(Color.primary.colorInvert())
                        }
                    }.background(Color(light: Library.customBlue1, dark: Library.customGray1)).onAppear
                    {
                        if list.name != "testing123"
                        {
                            taskCompletedValue = Float(vm.getInactiveCompletedTaskCount(list: list)) / Float(vm.getInactiveTaskList(tasklist: list).count)
                        }
                    }
                    
                        CalendarTaskListView(vm: vm, tasklist: $list)
                    
                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.2)) {
                            show = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40, alignment: .center)
                            .foregroundColor(Color(light: Color.white, dark: Color.black))
                            .font(.body)
                            .cornerRadius(15)
                    }).buttonStyle(PressableButtonStyle())
                        .frame(width: 100)
                        .background(Color(light: Color.blue, dark: Color.secondary))
                        .cornerRadius(15)
                        .padding([.bottom, .top], 10)
                        
                }
                //.frame(maxWidth: 280)
                .frame(width: 330, height: 500)
                .background(Color.primary.colorInvert())
                .cornerRadius(25)
            }
        }
    }
}


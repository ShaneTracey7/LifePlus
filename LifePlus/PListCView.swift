//
//  PListCView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-14.
//

import SwiftUI

struct PListCView: View {

    @ObservedObject var vm: CoreDataViewModel
    @Binding var sortSelection: Int
    @State var doubleCheck: Bool = false
    @Binding var gaugeDisplaysHours: Bool //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
   
    
    @State var tasklist: ListEntity
    
    var body: some View {
        
        ZStack{
            
            
            VStack(alignment: .leading, spacing: 0){
                
                NavigationLink(destination: TaskListView(vm: vm, tasklist: $tasklist)){
                    HStack{
                        Text(tasklist.name ?? "No name")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .padding([.leading], 15)
                            .multilineTextAlignment(.leading)
                        
                        if tasklist.name == "Daily TODO"
                        {
                            NavigationLink(destination: MyCalendarView(vm: vm)){
                                
                                Image(systemName: "calendar")
                            } .buttonStyle(PressableButtonStyle()).foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(PressableButtonStyle())
                .padding([.trailing], 20)
                
                HStack{
                    
                    if tasklist.isComplete{
                        Text("Completed").font(.caption2).foregroundColor(Color.green)
                            .frame(alignment: .leading)
                            .padding([.leading],20)
                            .padding([.top],5)
                        //.border(Color.red)
                    }
                    else
                    {
                        Spacer().frame(width: 85,height: 20)
                    }
                    Spacer().frame(minWidth: 50, maxWidth: 120)
                    
                    
                    if gaugeDisplaysHours
                    {
                        
                        Text("\(String(format: "%.1f", vm.getCompletedHourCount(list: tasklist))) / \(String(format: "%.1f", vm.getHourCount(list: tasklist)))")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 100,alignment: .trailing)
                        //.border(Color.red)
                        //.frame(maxWidth: 100)
                        //.padding([.trailing], 5)
                        
                        Text("hours")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 40, alignment: .leading)
                            .padding([.trailing], 20)
                    }
                    else
                    {
                        Text("\(String(format: "%.1f", vm.getCompletedTaskCount(list: tasklist))) / \(String(format: "%.1f", vm.getTaskCount(list: tasklist)))")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 100,alignment: .trailing)
                        //.border(Color.red)
                        //.frame(maxWidth: 100)
                        //.padding([.trailing], 5)
                        
                        Text("tasks")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(width:40, alignment: .leading)
                            .padding([.trailing], 20)
                        //.border(Color.red)
                    }
                }
                HStack{
                    
                    if gaugeDisplaysHours
                    {
                        Gauge(value: vm.getHoursValue(list: tasklist), in: 0...1){}.tint(Gradient(colors: [.blue, .green])).frame(width: 250)
                    }
                    else
                    {
                        Gauge(value: vm.getTasksValue(list: tasklist), in: 0...1){}.tint(Gradient(colors: [.blue, .green])).frame(width: 250)
                    }
                    
                       Spacer().frame(width: 40, height: 40)
                    
                }.padding([.leading], 25)
                
            // contains date
            HStack{
                if tasklist.name == "Weekly TODO"
                {
                        Text("Start: \((tasklist.startDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(lightColorChange)
                            .frame(width: 125, alignment: .leading)
                            .padding([.leading],30)
                        
                        Text("End: \((tasklist.endDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(lightColorChange)
                            .frame(width: 125, alignment: .leading)
                            .padding([.leading],30)
                    
                }
                else if tasklist.name == "Daily TODO"
                {
                        Text("Date: \((tasklist.startDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(lightColorChange)
                            .frame(width: 125, alignment: .leading)
                            .padding([.leading],30)
                    
                }
                else // for month
                {
                        Text("End: \((tasklist.endDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption)
                            .foregroundColor(lightColorChange)
                            .frame(width: 125, alignment: .leading)
                            .padding([.leading],30)
                    
                }
            }
            //.padding([.top, .bottom], 5)
            //.border(Color.red)
        }
        //.border(Color.green)
            .frame(width:350, height: 110)
            .background{
                ZStack(alignment: .top) {
                    
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 50)
                }
                .foregroundColor(colorChange)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
            .padding([.top], 5)
    
        }.frame(width: 410.0)//.border(Color.blue)
         .onAppear{
                if tasklist.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
                }
                else
                {
                    lightColorChange = Library.lightblueColor
                    colorChange = Library.blueColor
                }
            }
    }
}

struct PListCView_Previews: PreviewProvider {
    
    struct PListCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var gaugeDisplayHours: Bool = false
        @State var tasklist: ListEntity = ListEntity()
        
            var body: some View {
                PListCView(vm: self.vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplayHours, tasklist: tasklist)
            }
        }
    
    static var previews: some View {
        PListCViewContainer()
    }
}

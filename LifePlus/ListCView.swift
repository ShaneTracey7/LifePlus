//
//  ListCView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-13.
//

import SwiftUI

struct ListCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @Binding var sortSelection: Int
    @State var doubleCheck: Bool = false
    @Binding var gaugeDisplaysHours: Bool //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    @State var colorChange: Color = Color.black
    let blueColor: Color = Color(red: 0.65, green: 0.75, blue: 0.95)
    let greenColor: Color = Color(red: 0.55, green: 0.95, blue: 0.65)
    
    @State var lightColorChange: Color = Color.black
    let lightblueColor: Color = Color(red: 0.78, green: 0.90, blue: 1.14)
    let lightgreenColor: Color = Color(red: 0.78, green: 1.14, blue: 0.90)
    
    @State var tasklist: ListEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                NavigationLink(destination: TaskListView(vm: vm, tasklist: $tasklist)){
                    HStack{
                        Text(tasklist.name ?? "No name")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .padding([.leading], 15)
                            .multilineTextAlignment(.leading)
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
                    else if (tasklist.endDate ?? Date()) < Date()
                    {
                        
                        Text("Past Due").font(.caption2).foregroundColor(Color.red)
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
                    
                    //delete list button
                    Button(role: .destructive,
                           action: {
                        withAnimation{
                            print("delete button was pressed")
                            doubleCheck = true
                        }
                        
                    },
                           label: {
                        Image(systemName: "trash").imageScale(.medium).foregroundColor(Color.red)
                    })
                    .frame(width: 40, height: 40).frame(alignment: .trailing).padding([.trailing],10).buttonStyle(.plain)
                    .confirmationDialog(
                        "Are you sure? This will remove all the tasks and points gained for completing the tasks in the list.",
                        isPresented: $doubleCheck,
                        titleVisibility: .visible
                    )
                    {
                        Button("Yes", role: .destructive)
                        {
                            //reset sorting in listview
                            sortSelection = 0
                            
                            let index = vm.customListEntities.firstIndex(of:tasklist)
                            
                            // delete all tasks from taskEntities that have the same listId as list and the list and adjusts points
                            vm.deleteList(index: index ?? 0)
                            
                            print("confirmation delete button was pressed")
                        }
                        Button("No", role: .cancel){}
                    }
                    
                }.padding([.leading], 25)
                // contains date and duration
                HStack{
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
                       lightColorChange = lightgreenColor
                       colorChange = greenColor
                   }
                   else
                   {
                       lightColorChange = lightblueColor
                       colorChange = blueColor
                   }
               }
    }
}

struct ListCView_Previews: PreviewProvider {
    
    struct ListCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var gaugeDisplayHours: Bool = false
        @State var tasklist: ListEntity = ListEntity()
        
            var body: some View {
                ListCView(vm: self.vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplayHours, tasklist: tasklist)
            }
        }
    
    static var previews: some View {
        ListCViewContainer()
    }
}

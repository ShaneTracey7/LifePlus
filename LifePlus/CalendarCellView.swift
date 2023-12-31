//
//  CalendarCellView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-25.
//

import SwiftUI

struct CalendarCellView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @State var index: Int
    @Binding var cellArr: [Int]
    @Binding var monthInt: Int
    @Binding var year: Int
    @State var cellColor: Color = Color.blue
    @State var isPartial: Bool = false
    @Binding var showPopUp: Bool
    @Binding var dateStrTitle: String
    @Binding var list: ListEntity
    
    var body: some View {
        
        if cellArr[index] == 0
        {
           
            Rectangle().frame(width: 40, height: 40).foregroundColor(Library.customBlue2).cornerRadius(5)
        }
        else
        {
            Button( action:
            {
                var components = DateComponents()
                components.day = cellArr[index]
                components.month = monthInt
                components.year = year
                let dateSet = Calendar.current.date(from: components) ?? Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, YYYY"
                
                //function could be better
                /*for inactiveList in vm.inactiveListEntities
                {
                    
                    let listDate: Date = inactiveList.endDate ?? Date ()
                    let listComponents =  Calendar.current.dateComponents([.day, .month, .year],  from: listDate)
                    
                    if listComponents.day == components.day
                    {
                        if listComponents.month == components.month
                        {
                            if listComponents.year == components.year
                            {
                                list = inactiveList
                                vm.deletetestlist()
                                break
                            }
                            else
                            {
                                if list.name == "testing123"
                                {
                                    // DO NOTHING
                                }
                                else
                                {
                                    list = vm.addtestlist()
                                }
                            }
                        }
                        else
                        {
                            if list.name == "testing123"
                            {
                                // DO NOTHING
                            }
                            else
                            {
                                list = vm.addtestlist()
                            }
                        }
                    }
                    else
                    {
                        if list.name == "testing123"
                        {
                            // DO NOTHING
                        }
                        else
                        {
                            list = vm.addtestlist()
                        }
                    }
                }*/
                
                
                var flag: Bool = false
                for inactiveList in vm.inactiveListEntities
                {
                    
                    let listDate: Date = inactiveList.endDate ?? Date ()
                    let listComponents =  Calendar.current.dateComponents([.day, .month, .year],  from: listDate)
                    
                    if listComponents.day == components.day
                    {
                        if listComponents.month == components.month
                        {
                            if listComponents.year == components.year
                            {
                                list = inactiveList
                                //vm.deletetestlist()
                                flag = true
                                print("found correct inactive list")
                                break
                            }
                        }
                    }
                }
                
                if flag == false
                {
                    print("flag = false")
                    if list.name == "testing123"
                    {
                        // DO NOTHING
                    }
                    else
                    {
                    //list = vm.inactiveListEntities.first{$0.name == "testing123"} ?? ListEntity()
                        //var flag: Bool = false
                        for activeList in vm.inactiveListEntities
                        {
                            if activeList.name == "testing123"
                            {
                                list = activeList
                                //flag = true
                                break
                            }
                        }
                        /*
                        if !flag
                        {
                            list = vm.addtestlist()
                        }*/
                        
                        
                    }
                }
                else
                {
                    print("flag = true, list name: \(list.name ?? "ERROR")")
                    print("list date: \(list.endDate ?? Date().addingTimeInterval(86400))")
                }
                dateStrTitle = dateFormatter.string(from: dateSet)
                 
                showPopUp = true
            }, label:{
                if isPartial {
                    
                    ZStack{
                        Rectangle().frame(width: 40, height: 40).foregroundColor(Color.blue).cornerRadius(5)
                        Circle().trim(from: 0, to: 0.5).frame(width: 35, height: 35).rotationEffect(.degrees(90)).foregroundColor(cellColor).onChange(of: monthInt)
                        { newValue in
                            setCellCompleteness()
                        }
                        if cellArr[index] != 0
                        {
                            Text("\(cellArr[index])").font(.body).foregroundColor(Color.primary)
                        }
                    }.frame(width: 40, height: 40).background(Color.blue).cornerRadius(5)
                        .onAppear
                    {
                        setCellCompleteness()
                    }
                    
                }
                else
                {
                    
                    ZStack{
                        
                        Circle().frame(width: 35, height: 35).foregroundColor(cellColor).onChange(of: monthInt)
                        { newValue in
                            setCellCompleteness()
                        }
                        if cellArr[index] != 0
                        {
                            Text("\(cellArr[index])").font(.body).foregroundColor(Color.primary)
                        }
                    }.frame(width: 40, height: 40).background(Color.blue).cornerRadius(5)
                        .onAppear
                    {
                        setCellCompleteness()
                    }
                }
            }).buttonStyle(PressableButtonStyle())
        }
        
    }
    
    //changes cellColor attribute base upon completeness od cell
    func setCellCompleteness()
    {
        vm.fetchCalendarCells()
        
        for cell in vm.calendarCellEntities
        {
            let cellDate: Date = cell.date ?? Date()
            var components = DateComponents()
            components.day = Calendar.current.dateComponents([.day], from: cellDate).day
            components.month = Calendar.current.dateComponents([.month], from: cellDate).month
            components.year = Calendar.current.dateComponents([.year], from: cellDate).year
            
            if components.day == cellArr[index]
            {
                if components.month == monthInt{
                    
                    if components.year == year
                    {
                        
                        switch cell.completeness
                        {
                        case "Complete":
                            cellColor = Color.green
                            isPartial = false
                        case "Mostly":
                            cellColor = Color.green //implement half circle
                            isPartial = true
                        case "Some":
                            cellColor = Color.red //implement half circle
                            isPartial = true
                        case "None":
                            cellColor = Color.red
                            isPartial = false
                        default: /* "Zero" */
                            cellColor = Color.blue
                            isPartial = false
                        }
                        break
                    }
                    else
                    {
                        cellColor = Color.blue
                    }
                }
                else
                {
                    cellColor = Color.blue
                }
            }
            else
            {
                cellColor = Color.blue
            }
            
            
        }
        
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    
    struct CalendarCellViewContainer: View {
       // @State var isSelected: Bool = true
        @State var vm = CoreDataViewModel()
        @State var index: Int = 0
        @State var cellArr: [Int] = []
        @State var monthInt: Int = 1
        @State var year: Int = 1
        @State var showPopUp: Bool = false
        @State var dateStrTitle: String = ""
        @State var list : ListEntity = ListEntity()
            var body: some View {
                CalendarCellView(vm: vm, index: index, cellArr: $cellArr, monthInt: $monthInt, year: $year, showPopUp: $showPopUp, dateStrTitle: $dateStrTitle, list: $list)
                
            }
        }
    static var previews: some View {
        CalendarCellViewContainer()
    }
}

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
            var body: some View {
                CalendarCellView(vm: vm, index: index, cellArr: $cellArr, monthInt: $monthInt, year: $year, showPopUp: $showPopUp, dateStrTitle: $dateStrTitle)
                
            }
        }
    static var previews: some View {
        CalendarCellViewContainer()
    }
}

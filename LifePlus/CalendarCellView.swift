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
    
    var body: some View {
        
        if cellArr[index] == 0
        {
           
            Rectangle().frame(width: 40, height: 40).foregroundColor(Library.customBlue2).cornerRadius(5)
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
                        if cell.isComplete
                        {
                            cellColor = Color.green
                        }
                        else
                        {
                            cellColor = Color.red
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
            var body: some View {
                CalendarCellView(vm: vm, index: index, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                
            }
        }
    static var previews: some View {
        CalendarCellViewContainer()
    }
}

//
//  MyCalendarView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-24.
//

import SwiftUI

struct MyCalendarView: View {
    
    @State var index: Int = 0
    @State var offset: Int = 0 // 1-7 (1 being sunday) for weekday 
    @State var day: Int = 0
    @State var monthStr: String = ""
    @State var year: Int = 0
    @State var cellArr: [Int] = [] // = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
    
    var body: some View {
        
        
        
        
        VStack{
            // current month and next and last month buttons
            HStack{
                Button(action:
                    {
                    previousMonth(month: monthStr)
                    cellArr = setCalendarCells()
                    },
                       label:
                        {
                    Image(systemName: "arrow.left.circle")
                })
                Text(monthStr)
                Button(action: {print("nothing")},
                       label:
                        {
                    Image(systemName: "arrow.right.circle")
                })
            }.font(.title)
            //day of week labels
            HStack
            {
                Text("S").frame(width: 30).padding(.horizontal, 5)
                Text("M").frame(width: 30).padding(.horizontal, 5)
                Text("T").frame(width: 30).padding(.horizontal, 5)
                Text("W").frame(width: 30).padding(.horizontal, 5)
                Text("T").frame(width: 30).padding(.horizontal, 5)
                Text("F").frame(width: 30).padding(.horizontal, 5)
                Text("S").frame(width: 30).padding(.horizontal, 5)
            }.font(.title)
            
            if !cellArr.isEmpty
            {
                //calendar
                VStack
            {
                //1st week
                HStack
                {
                    
                    CalendarCellView(index: 0, cellArr: $cellArr)
                    CalendarCellView(index: 1, cellArr: $cellArr)
                    CalendarCellView(index: 2, cellArr: $cellArr)
                    CalendarCellView(index: 3, cellArr: $cellArr)
                    CalendarCellView(index: 4, cellArr: $cellArr)
                    CalendarCellView(index: 5, cellArr: $cellArr)
                    CalendarCellView(index: 6, cellArr: $cellArr)
                }
                //2nd week
                HStack
                {
                    
                    CalendarCellView(index: 7, cellArr: $cellArr)
                    CalendarCellView(index: 8, cellArr: $cellArr)
                    CalendarCellView(index: 9, cellArr: $cellArr)
                    CalendarCellView(index: 10, cellArr: $cellArr)
                    CalendarCellView(index: 11, cellArr: $cellArr)
                    CalendarCellView(index: 12, cellArr: $cellArr)
                    CalendarCellView(index: 13, cellArr: $cellArr)
                }
                //3rd week
                HStack
                {
                    
                    CalendarCellView(index: 14, cellArr: $cellArr)
                    CalendarCellView(index: 15, cellArr: $cellArr)
                    CalendarCellView(index: 16, cellArr: $cellArr)
                    CalendarCellView(index: 17, cellArr: $cellArr)
                    CalendarCellView(index: 18, cellArr: $cellArr)
                    CalendarCellView(index: 19, cellArr: $cellArr)
                    CalendarCellView(index: 20, cellArr: $cellArr)
                }
                //4th week
                HStack
                {
                    CalendarCellView(index: 21, cellArr: $cellArr)
                    CalendarCellView(index: 22, cellArr: $cellArr)
                    CalendarCellView(index: 23, cellArr: $cellArr)
                    CalendarCellView(index: 24, cellArr: $cellArr)
                    CalendarCellView(index: 25, cellArr: $cellArr)
                    CalendarCellView(index: 26, cellArr: $cellArr)
                    CalendarCellView(index: 27, cellArr: $cellArr)
                    
                }
                //5th week
                HStack
                {
                    CalendarCellView(index: 28, cellArr: $cellArr)
                    CalendarCellView(index: 29, cellArr: $cellArr)
                    CalendarCellView(index: 30, cellArr: $cellArr)
                    CalendarCellView(index: 31, cellArr: $cellArr)
                    CalendarCellView(index: 32, cellArr: $cellArr)
                    CalendarCellView(index: 33, cellArr: $cellArr)
                    CalendarCellView(index: 34, cellArr: $cellArr)
                }
                //6th week
                
                if !(cellArr[35] == 0)
                {
                    HStack
                    {
                        CalendarCellView(index: 35, cellArr: $cellArr)
                        CalendarCellView(index: 36, cellArr: $cellArr)
                        CalendarCellView(index: 37, cellArr: $cellArr)
                        CalendarCellView(index: 38, cellArr: $cellArr)
                        CalendarCellView(index: 39, cellArr: $cellArr)
                        CalendarCellView(index: 40, cellArr: $cellArr)
                        CalendarCellView(index: 41, cellArr: $cellArr)
                    }
                }
            }
        }
        }.onAppear{
            
            let td = Date()
            
            day = Calendar.current.dateComponents([.day], from: td).day ?? 1
            monthStr = Date().formatted(Date.FormatStyle().month(.wide))
            year = Calendar.current.dateComponents([.year], from: td).year ?? 1
            
            var components = DateComponents()
            components.day = 1
            components.month = Calendar.current.dateComponents([.month], from: td).month ?? 1
            components.year = year
            
            let firstOfMonth = Calendar.current.date(from: components) ?? Date()
            print("First of month Date: \(firstOfMonth.formatted(date: .complete, time: .omitted))")
            offset = Calendar.current.dateComponents([.weekday], from: firstOfMonth).weekday ?? 1
            
            cellArr = setCalendarCells()
        }
    }
    
    
    
    func setCalendarCells () -> [Int]
    {
        print("offset: \(offset)")
        let offset1 = offset - 1
        var count = 0
        var arr2: [Int] = []
        while count < offset1
        {
            arr2.append(0)
            count += 1
        }
        print("count after first: \(count)")
        var count2 = 1
        while count < 42
        {
            if count2 > 31
            {
                arr2.append(0)
            }
            else
            {
                arr2.append(count2)
            }
            count += 1
            count2 += 1
        }
        print("count after second: \(count)")
        print ("\(arr2.count)")
        return arr2
    }
    
    func previousMonth(month: String)
    {
        
        var components = DateComponents()
        components.day = 1
        
        
        switch month
        {
        case "January":
            components.month = 12
            monthStr = "December"
            year = year - 1
        case "February":
            components.month = 1
            monthStr = "January"
        case "March":
            components.month = 2
            monthStr = "February"
        case "April":
            components.month = 3
            monthStr = "March"
        case "May":
            components.month = 4
            monthStr = "April"
        case "June":
            components.month = 5
            monthStr = "May"
        case "July":
            components.month = 6
            monthStr = "June"
        case "August":
            components.month = 7
            monthStr = "July"
        case "September":
            components.month = 8
            monthStr = "August"
        case "October":
            components.month = 9
            monthStr = "September"
        case "November":
            components.month = 10
            monthStr = "October"
        case "December":
            components.month = 11
            monthStr = "November"
        default:
            components.month = 1
        }
        
        components.year = year
        
        let firstOfMonth = Calendar.current.date(from: components) ?? Date()
        print("First of month Date: \(firstOfMonth.formatted(date: .complete, time: .omitted))")
        offset = Calendar.current.dateComponents([.weekday], from: firstOfMonth).weekday ?? 1
    }
}

struct MyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarView()
    }
}

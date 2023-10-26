//
//  MyCalendarView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-24.
//

import SwiftUI

struct MyCalendarView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @State var index: Int = 0
    @State var offset: Int = 0 // 1-7 (1 being sunday) for weekday 
    @State var day: Int = 0
    @State var monthStr: String = ""
    @State var monthInt: Int = 1
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
                }).buttonStyle(PressableButtonStyle())
                Text(monthStr).foregroundColor(Color.blue).frame(width: 150)
                Button(action:
                        {
                    nextMonth(month: monthStr)
                    cellArr = setCalendarCells()
                },
                       label:
                        {
                    Image(systemName: "arrow.right.circle")
                }).buttonStyle(PressableButtonStyle())
            }.font(.title)
            
            Text(String(year)).font(.title2).foregroundColor(Color.blue)
            
            Spacer().frame(height: 20)
            
            //day of week labels
            HStack
            {
                Text("Sun").frame(width: 36).padding(.horizontal, 2)
                Text("Mon").frame(width: 36).padding(.horizontal, 2)
                Text("Tue").frame(width: 36).padding(.horizontal, 2)
                Text("Wed").frame(width: 36).padding(.horizontal, 2)
                Text("Thu").frame(width: 36).padding(.horizontal, 2)
                Text("Fri").frame(width: 36).padding(.horizontal, 2)
                Text("Sat").frame(width: 36).padding(.horizontal, 2)
            }.font(.body)
            
            if !cellArr.isEmpty
            {
            //calendar
            VStack
            {
                //1st week
                HStack
                {
                    
                    CalendarCellView(vm: vm, index: 0, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 1, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 2, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 3, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 4, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 5, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 6, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                }
                //2nd week
                HStack
                {
                    
                    CalendarCellView(vm: vm, index: 7, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 8, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 9, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 10, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 11, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 12, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 13, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                }
                //3rd week
                HStack
                {
                    
                    CalendarCellView(vm: vm, index: 14, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 15, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 16, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 17, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 18, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 19, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 20, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                }
                //4th week
                HStack
                {
                    CalendarCellView(vm: vm, index: 21, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 22, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 23, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 24, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 25, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 26, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 27, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    
                }
                //5th week
                HStack
                {
                    CalendarCellView(vm: vm, index: 28, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 29, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 30, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 31, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 32, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 33, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    CalendarCellView(vm: vm, index: 34, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                }
                //6th week
                
                if !(cellArr[35] == 0)
                {
                    HStack
                    {
                        CalendarCellView(vm: vm, index: 35, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 36, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 37, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 38, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 39, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 40, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                        CalendarCellView(vm: vm, index: 41, cellArr: $cellArr, monthInt: $monthInt, year: $year)
                    }
                }
                else
                {
                    Spacer().frame(height: 56)
                }
            }
            }
            
            //legend
            VStack(alignment: .leading, spacing: 10)
            {
                Text("Legend:").foregroundColor(Color.primary).font(.title3)
                HStack(spacing: 0)
                {   //complete
                    VStack
                    {
                        ZStack{
                            Rectangle().frame(width: 30, height: 30).foregroundColor(Color.blue).cornerRadius(5)
                            Circle().frame(width: 25, height: 25).foregroundColor(Color.green)
                        }
                        Text("Complete").foregroundColor(Color.primary).font(.caption2)
                    }.frame(width: 55)
                    /*
                    //mostly complete
                    VStack
                    {
                        ZStack{
                            Rectangle().frame(width: 30, height: 30).foregroundColor(Color.blue)
                            Circle().trim(from: 0, to: 0.5).frame(width: 25, height: 25).rotationEffect(.degrees(90)).foregroundColor(Color.green)
                        }.frame(width: 30)
                        Text("Mostly").foregroundColor(Color.primary).font(.caption2)
                    }.frame(width: 55)
                    
                    //some complete
                    VStack
                    {
                        ZStack{
                            Rectangle().frame(width: 30, height: 30).foregroundColor(Color.blue)
                            Circle().trim(from: 0, to: 0.5).frame(width: 25, height: 25).rotationEffect(.degrees(90)).foregroundColor(Color.red)
                        }.frame(width: 30)
                        Text("Some").foregroundColor(Color.primary).font(.caption2)
                    }.frame(width: 55)
                    */
                    //incomplete
                    VStack
                    {
                        ZStack{
                            Rectangle().frame(width: 30, height: 30).foregroundColor(Color.blue).cornerRadius(5)
                            Circle().frame(width: 25, height: 25).foregroundColor(Color.red)
                        }
                        Text("Incomplete").foregroundColor(Color.primary).font(.caption2)
                    }.frame(width: 70)
                    Spacer()
                }
            }.frame(maxWidth: .infinity).padding([.top], 10).padding([.leading], 40)
            
            Spacer()
        }.onAppear{
            
            let td = Date()
            
            day = Calendar.current.dateComponents([.day], from: td).day ?? 1
            monthStr = Date().formatted(Date.FormatStyle().month(.wide))
            monthInt = Calendar.current.dateComponents([.month], from: td).month ?? 1
            year = Calendar.current.dateComponents([.year], from: td).year ?? 1
            
            var components = DateComponents()
            components.day = 1
            components.month = monthInt
            components.year = year
            
            let firstOfMonth = Calendar.current.date(from: components) ?? Date()
            print("First of month Date: \(firstOfMonth.formatted(date: .complete, time: .omitted))")
            offset = Calendar.current.dateComponents([.weekday], from: firstOfMonth).weekday ?? 1
            
            cellArr = setCalendarCells()
        }
    }
    
    
    
    func setCalendarCells () -> [Int]
    {
        var daysInMonth: Int
        
        
        if monthStr == "February"
        {
            //idc about leap year rn
            daysInMonth = 28
        }
        else if monthStr == "April" || monthStr == "June" || monthStr == "September" || monthStr == "November"
        {
            daysInMonth = 30
        }
        else
        {
            daysInMonth = 31
        }
        
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
            if count2 > daysInMonth
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
            monthInt = 12
            year = year - 1
        case "February":
            components.month = 1
            monthStr = "January"
            monthInt = 1
        case "March":
            components.month = 2
            monthStr = "February"
            monthInt = 2
        case "April":
            components.month = 3
            monthStr = "March"
            monthInt = 3
        case "May":
            components.month = 4
            monthStr = "April"
            monthInt = 4
        case "June":
            components.month = 5
            monthStr = "May"
            monthInt = 5
        case "July":
            components.month = 6
            monthStr = "June"
            monthInt = 6
        case "August":
            components.month = 7
            monthStr = "July"
            monthInt = 7
        case "September":
            components.month = 8
            monthStr = "August"
            monthInt = 8
        case "October":
            components.month = 9
            monthStr = "September"
            monthInt = 9
        case "November":
            components.month = 10
            monthStr = "October"
            monthInt = 10
        case "December":
            components.month = 11
            monthStr = "November"
            monthInt = 11
        default:
            components.month = 1
        }
        
        components.year = year
        
        let firstOfMonth = Calendar.current.date(from: components) ?? Date()
        print("First of month Date: \(firstOfMonth.formatted(date: .complete, time: .omitted))")
        offset = Calendar.current.dateComponents([.weekday], from: firstOfMonth).weekday ?? 1
    }
    
    func nextMonth(month: String)
    {
        
        var components = DateComponents()
        components.day = 1
        
        
        switch month
        {
        case "January":
            components.month = 2
            monthInt = 2
            monthStr = "February"
        case "February":
            components.month = 3
            monthInt = 3
            monthStr = "March"
        case "March":
            components.month = 4
            monthStr = "April"
            monthInt = 4
        case "April":
            components.month = 5
            monthStr = "May"
            monthInt = 5
        case "May":
            components.month = 6
            monthStr = "June"
            monthInt = 6
        case "June":
            components.month = 7
            monthStr = "July"
            monthInt = 7
        case "July":
            components.month = 8
            monthStr = "August"
            monthInt = 8
        case "August":
            components.month = 9
            monthStr = "September"
            monthInt = 9
        case "September":
            components.month = 10
            monthStr = "October"
            monthInt = 10
        case "October":
            components.month = 11
            monthStr = "November"
            monthInt = 11
        case "November":
            components.month = 12
            monthStr = "December"
            monthInt = 12
        case "December":
            components.month = 1
            monthStr = "January"
            monthInt = 1
            year = year + 1
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
    
    struct MyCalendarViewContainer: View {
        @State var vm = CoreDataViewModel()

            var body: some View {
                MyCalendarView(vm: vm)
                
            }
        }
    static var previews: some View {
        MyCalendarViewContainer()
    }
}

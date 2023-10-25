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
    @State var month: String = ""
    @State var year: Int = 0
    @State var arr: [Int] = []
    
    var body: some View {
        
        
        
        
        VStack{
            // current month and next and last month buttons
            HStack{
                Button(action: {print("nothing")},
                       label:
                        {
                    Image(systemName: "arrow.left.circle")
                })
                Text(month)
                Button(action: {print("nothing")},
                       label:
                        {
                    Image(systemName: "arrow.right.circle")
                })
            }.font(.title)
            //day of week labels
            HStack
            {
                Text("S").padding(.horizontal, 10)
                Text("M").padding(.horizontal, 10)
                Text("T").padding(.horizontal, 10)
                Text("W").padding(.horizontal, 10)
                Text("T").padding(.horizontal, 10)
                Text("F").padding(.horizontal, 10)
                Text("S").padding(.horizontal, 10)
            }.font(.title)
            
            //calendar
            VStack
            {
                //1st week
                HStack
                {
                
                    CalendarCellView(dayNum: arr[0])
                    CalendarCellView(dayNum: arr[1])
                    CalendarCellView(dayNum: arr[2])
                    CalendarCellView(dayNum: arr[3])
                    CalendarCellView(dayNum: arr[4])
                    CalendarCellView(dayNum: arr[5])
                    CalendarCellView(dayNum: arr[6])
                }
                //2nd week
                HStack
                {
                    CalendarCellView(dayNum: arr[7])
                    CalendarCellView(dayNum: arr[8])
                    CalendarCellView(dayNum: arr[9])
                    CalendarCellView(dayNum: arr[10])
                    CalendarCellView(dayNum: arr[11])
                    CalendarCellView(dayNum: arr[12])
                    CalendarCellView(dayNum: arr[13])
                }
                //3rd week
                HStack
                {
                    CalendarCellView(dayNum: arr[14])
                    CalendarCellView(dayNum: arr[15])
                    CalendarCellView(dayNum: arr[16])
                    CalendarCellView(dayNum: arr[17])
                    CalendarCellView(dayNum: arr[18])
                    CalendarCellView(dayNum: arr[19])
                    CalendarCellView(dayNum: arr[20])
                }
                //4th week
                HStack
                {
                    CalendarCellView(dayNum: arr[21])
                    CalendarCellView(dayNum: arr[22])
                    CalendarCellView(dayNum: arr[23])
                    CalendarCellView(dayNum: arr[24])
                    CalendarCellView(dayNum: arr[25])
                    CalendarCellView(dayNum: arr[26])
                    CalendarCellView(dayNum: arr[27])
                }
                //5th week
                HStack
                {
                    CalendarCellView(dayNum: arr[28])
                    CalendarCellView(dayNum: arr[29])
                    CalendarCellView(dayNum: arr[30])
                    CalendarCellView(dayNum: arr[31])
                    CalendarCellView(dayNum: arr[32])
                    CalendarCellView(dayNum: arr[33])
                    CalendarCellView(dayNum: arr[34])
                }
                //6th week
                HStack
                {
                    CalendarCellView(dayNum: arr[35])
                    CalendarCellView(dayNum: arr[36])
                    CalendarCellView(dayNum: arr[37])
                    CalendarCellView(dayNum: arr[38])
                    CalendarCellView(dayNum: arr[39])
                    CalendarCellView(dayNum: arr[40])
                    CalendarCellView(dayNum: arr[41])
                }
            }
        }.onAppear{
            
            let td = Date()
            
            day = Calendar.current.dateComponents([.day], from: td).day ?? 1
            month = Date().formatted(Date.FormatStyle().month(.wide))
            year = Calendar.current.dateComponents([.year], from: td).year ?? 1
            
            var components = DateComponents()
            components.day = day
            components.month = Calendar.current.dateComponents([.month], from: td).month ?? 1
            components.year = year
            
            let firstOfMonth = Calendar.current.date(from: components) ?? Date()
            offset = Calendar.current.dateComponents([.weekday], from: firstOfMonth).weekday ?? 1
            
            arr = setCalendarCells()
        }
    }
    
    
    
    func setCalendarCells () -> [Int]
    {
        let offset1 = offset - 1
        var count = 0
        var arr: [Int] = []
        while count < offset1
        {
            arr.append(0)
            count += 1
        }
        var count2 = 0
        while count < 42
        {
            if count2 > 31
            {
                arr.append(0)
            }
            arr.append(count2)
            count += 1
            count2 += 1
        }
        
        return arr
    }
}

struct MyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarView()
    }
}

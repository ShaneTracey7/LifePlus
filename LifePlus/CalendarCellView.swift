//
//  CalendarCellView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-25.
//

import SwiftUI

struct CalendarCellView: View {
    
    @State var index: Int
    @State var isSelected: Bool = false
    @Binding var cellArr: [Int]
    
    var body: some View {
        
        ZStack{
            if isSelected
            {
                Circle().foregroundColor(Color.red)
            }
            if cellArr[index] != 0
            {
                Text("\(cellArr[index])").font(.body).foregroundColor(Color.primary)
            }
        }.frame(width: 30, height: 40).background(Color.secondary).padding(.horizontal, 5)
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    
    struct CalendarCellViewContainer: View {
       // @State var isSelected: Bool = true
        @State var index: Int = 0
        @State var cellArr: [Int] = []
            var body: some View {
               // CalendarCellView(dayNum: dayNum /* , isSelected: $isSelected*/)
                CalendarCellView(index: index, cellArr: $cellArr/* , isSelected: $isSelected*/)
                
            }
        }
    static var previews: some View {
        CalendarCellViewContainer()
    }
}

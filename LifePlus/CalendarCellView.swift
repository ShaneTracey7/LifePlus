//
//  CalendarCellView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-25.
//

import SwiftUI

struct CalendarCellView: View {
    
    @State var dayNum: Int
    @State var isSelected: Bool = false
    
    var body: some View {
        
        ZStack{
            if isSelected
            {
                Circle().foregroundColor(Color.red)
            }
            if dayNum != 0
            {
                Text("\(dayNum)").font(.body).foregroundColor(Color.primary)
            }
        }.frame(width: 30, height: 40).background(Color.secondary).padding(.horizontal, 5)
    }
}

struct CalendarCellView_Previews: PreviewProvider {
    
    struct CalendarCellViewContainer: View {
       // @State var isSelected: Bool = true
        @State var dayNum: Int = 0
            var body: some View {
                CalendarCellView(dayNum: dayNum /* , isSelected: $isSelected*/)
                
            }
        }
    static var previews: some View {
        CalendarCellViewContainer()
    }
}

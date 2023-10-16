//
//  CalendarListsView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-15.
//

import SwiftUI

struct CalendarListsView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var sortSelection: Int
    @Binding var isCalendar: Bool
    @Binding var gaugeDisplaysHours: Bool //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    var body: some View {
        
        ZStack{

           // VStack{
            /*
            VStack(spacing:0){
                HStack(spacing:0){
                    Text("Task").font(.body).foregroundColor(Color.primary)
                    Toggle("",isOn: $gaugeDisplaysHours ).toggleStyle(.switch).frame(width: 50).padding([.trailing], 10)
                    Text("Hours").font(.body).foregroundColor(Color.primary)
                }
                
                Divider().padding([.top], 5)
            }.frame(maxWidth: .infinity)
             */
            ScrollView{
                ForEach(vm.calendarListEntities) { tasklist in
                    
                    PListCView(vm: vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplaysHours, tasklist: tasklist)
                }
            }
                
           // }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear{ isCalendar = true}
        }
    }


struct CalendarListsView_Previews: PreviewProvider {
    
    struct CalendarListsViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var isCalendar: Bool = true
        @State var gaugeDisplaysHours: Bool =  false
            var body: some View {
                CalendarListsView(vm: vm, sortSelection: $sortSelection, isCalendar: $isCalendar, gaugeDisplaysHours: $gaugeDisplaysHours)
            }
        }
    
    static var previews: some View {
        CalendarListsViewContainer()
        
    }
}




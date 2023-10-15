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
    //@State var sortSelection: Int = 0
    @State var gaugeDisplaysHours: Bool = false //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    @Binding var isCalendar: Bool
    var body: some View {
        
        ZStack{
        
       // NavigationStack{
            VStack{
                    /*
                    Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
                    {
                        Text("Date").tag(1)
                        Text("Progress").tag(2)
                        Text("Complete").tag(3)
                    }.pickerStyle(.segmented).frame(width: 300)
                        .padding([.bottom], 0)
                        .onChange(of: sortSelection) { newValue in
                            vm.sortList2(choice: newValue)
                        }
                     */
                     
            VStack(spacing:0){
                HStack(spacing:0){
                    Text("Task").font(.body).foregroundColor(Color.primary)//.border(Color.red)
                    Toggle("",isOn: $gaugeDisplaysHours ).toggleStyle(.switch).frame(width: 50).padding([.trailing], 10)
                    Text("Hours").font(.body).foregroundColor(Color.primary)//.border(Color.red)
                }//.border(Color.green)
                
                Divider().padding([.top], 5)
            }.frame(maxWidth: .infinity)//.border(Color.red)
            ScrollView{
                ForEach(vm.calendarListEntities) { tasklist in
                    
                    PListCView(vm: vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplaysHours, tasklist: tasklist)
                    
                }
            }
            //.navigationTitle("Lists")
           // .toolbar {
                
                /*NavigationLink(destination: AddListView(vm: self.vm, sortSelection: $sortSelection)){
                    Image(systemName: "plus")
                 }
                 */
                
               // }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear{ isCalendar = true}
        //.background(Color.white)
        }
    }


struct CalendarListsView_Previews: PreviewProvider {
    
    struct CalendarListsViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var isCalendar: Bool = true
            var body: some View {
                CalendarListsView(vm: vm, sortSelection: $sortSelection, isCalendar: $isCalendar)
            }
        }
    
    static var previews: some View {
        CalendarListsViewContainer()
        
    }
}




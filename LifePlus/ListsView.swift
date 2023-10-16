//
//  ListsView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-13.
//

import SwiftUI

struct ListsView: View {
    
    @ObservedObject var vm: CoreDataViewModel
   
    
    @Binding var isCalendar: Bool
    @Binding var sortSelection: Int
    @Binding var gaugeDisplaysHours: Bool //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    var body: some View {
        
        ZStack{
            
            ScrollView{
                ForEach(vm.customListEntities) { tasklist in
                        
                    ListCView(vm: vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplaysHours, tasklist: tasklist)
                    }
                }
            
            if vm.customListEntities.isEmpty{
                Text("There are no lists").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear{ isCalendar = false}
        }
    }

struct ListsView_Previews: PreviewProvider {
    
    struct ListsViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var isCalendar: Bool = false
        @State var sortSelection: Int = 0
        @State var gaugeDisplaysHours: Bool = false
            var body: some View {
                ListsView(vm: vm, isCalendar: $isCalendar, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplaysHours)
            }
        }
    
    static var previews: some View {
        ListsViewContainer()
        
    }
}



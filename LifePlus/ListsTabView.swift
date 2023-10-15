//
//  ListsTabView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-15.
//

import SwiftUI

struct ListsTabView: View {
    
        @ObservedObject var vm: CoreDataViewModel
        
        @State var sortSelection: Int = 0
        @State var isCalendar: Bool = true
    
        var body: some View {
            
            NavigationStack{
                
                Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
                {
                    Text("Date").tag(1)
                    Text("Progress").tag(2)
                    Text("Complete").tag(3)
                }.pickerStyle(.segmented).frame(width: 300)
                    .padding([.bottom], 0)
                    .onChange(of: sortSelection) { newValue in
                        if isCalendar{
                            vm.sortList2(choice: newValue)
                        }
                        else
                        {
                            vm.sortList(choice: newValue)
                        }
                    }
                
                TabView {
                    
                        CalendarListsView(vm: vm , sortSelection: $sortSelection, isCalendar: $isCalendar )
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }
                        
                        ListsView(vm: vm, isCalendar: $isCalendar, sortSelection: $sortSelection)
                        .tabItem {
                            Label("Custom", systemImage: "list.star")
                        }
                }
            }.environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
             .navigationTitle("Lists")
             .toolbar {
                    if !isCalendar
                        {
                            NavigationLink(destination: AddListView(vm: self.vm, sortSelection: $sortSelection)){
                            Image(systemName: "plus")
                        }
                     }
                     
                    
                    }
            
            
        }
    }

    struct ListsTabView_Previews: PreviewProvider {
        struct ListsTabViewContainer: View {
            @State var vm = CoreDataViewModel()
            

                var body: some View {
                    ListsTabView(vm: self.vm)
                }
            }
        static var previews: some View {
            ListsTabViewContainer()
        }
    }

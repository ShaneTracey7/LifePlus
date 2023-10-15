//
//  ListsTabView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-15.
//

import SwiftUI

struct ListsTabView: View {
    
        @ObservedObject var vm: CoreDataViewModel
        
        var body: some View {
            
            TabView {
                CalendarListsView(vm: vm)
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                ListsView(vm: vm)
                    .tabItem {
                        Label("Custom", systemImage: "list.star")
                    }
            }.environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
            
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

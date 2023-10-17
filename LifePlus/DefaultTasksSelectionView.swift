//
//  DefaultTasksView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-17.
//

import SwiftUI

struct DefaultTasksSelectionView: View {
    
@ObservedObject var vm: CoreDataViewModel

    @State var dailytasklist: ListEntity = ListEntity()
    @State var weeklytasklist: ListEntity = ListEntity()
    @State var monthlytasklist: ListEntity = ListEntity()
    var body: some View {
        
        NavigationView{
        
            VStack{
                
                Text("Default Tasks").font(.title).foregroundColor(Color.primary)
                
                List{
                    
                    NavigationLink(destination: TaskListView(vm: vm, tasklist: $dailytasklist)){
                    
                        Text("Daily TODO").foregroundColor(Color.primary)
                                
                    }.buttonStyle(.plain)
                    
                    NavigationLink(destination: TaskListView(vm: vm, tasklist: $weeklytasklist )){
                    
                        Text("Weekly TODO").foregroundColor(Color.primary)
                                
                    }.buttonStyle(.plain)
                    
                    NavigationLink(destination: TaskListView(vm: vm, tasklist: $monthlytasklist )){
                    
                        Text("Monthly TODO").foregroundColor(Color.primary)
                                
                    }.buttonStyle(.plain)
                    
                }
                
            }
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.primary).environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
            .onAppear
        {
            dailytasklist = vm.defaultListEntities[0]
            print(dailytasklist)
            
            weeklytasklist = vm.defaultListEntities[1]
            print(weeklytasklist)
            
            monthlytasklist = vm.defaultListEntities[2]
            print(monthlytasklist)
        }
    }
}

struct DefaultTasksSelectionView_Previews: PreviewProvider {
    struct DefaultTasksSelectionViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                DefaultTasksSelectionView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        DefaultTasksSelectionViewContainer()
    }
}

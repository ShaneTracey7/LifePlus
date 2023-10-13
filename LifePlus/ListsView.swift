//
//  ListsView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-13.
//

import SwiftUI

struct ListsView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var sortSelection: Int = 0
    @State var gaugeDisplaysHours: Bool = false //will be a toggle in ListsView that switches the gauge from showing progress by hours or task
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            
            Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
            {
                Text("Date").tag(1)
                Text("Progress").tag(2)
                Text("Complete").tag(3)
            }.pickerStyle(.segmented).frame(width: 300)
                .padding([.bottom], 5)
                .onChange(of: sortSelection) { newValue in
                    vm.sortGoal(choice: newValue)
                            }
            VStack{
                
                Text("Display by:").font(.body)
                HStack(spacing: 10){
                    Text("Task").font(.body).foregroundColor(Color.white).multilineTextAlignment(.center)
                    Toggle("",isOn: $gaugeDisplaysHours ).toggleStyle(.switch).padding([.trailing],15).padding([.bottom],5)
                    Text("Hours").font(.body).foregroundColor(Color.white).multilineTextAlignment(.center)
                }.frame(width: 75)
            }
            ScrollView{
                ForEach(vm.listEntities) { tasklist in
                    
                    ListCView(vm: vm, sortSelection: $sortSelection, gaugeDisplaysHours: $gaugeDisplaysHours, tasklist: tasklist)
                    
                }
            }
            .navigationTitle("Lists")
            .toolbar {
                
                NavigationLink(destination: AddGoalView(vm: self.vm, sortSelection: $sortSelection)){
                    Image(systemName: "plus")
                }
                
            }
            }
            
            if vm.goalEntities.isEmpty{
                Text("There are no goals").frame(maxWidth: .infinity).foregroundColor(Color.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        //.background(Color.white)
        }
    }


struct ListsView_Previews: PreviewProvider {
    
    struct ListsViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                GoalView(vm: vm)
            }
        }
    
    static var previews: some View {
        ListsViewContainer()
        
    }
}



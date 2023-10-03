//
//  GoalView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct GoalView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var sortSelection: Int = 0
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
            
            ScrollView{
                ForEach(vm.goalEntities) { goal in
                    
                    GoalCView(vm: vm, sortSelection: $sortSelection, goal: goal)
                    
                }
            }
            .navigationTitle("Goal")
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


struct GoalView_Previews: PreviewProvider {
    
    struct GoalViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                GoalView(vm: vm)
            }
        }
    
    static var previews: some View {
        GoalViewContainer()
        
    }
}




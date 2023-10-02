//
//  GoalView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct GoalView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            ScrollView{
                ForEach(vm.goalEntities) { goal in
                    
                    GoalCView(vm: vm, goal: goal)
                    
                }
            }
            .navigationTitle("Goal")
            .toolbar {
                
                NavigationLink(destination: AddGoalView(vm: self.vm)){
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




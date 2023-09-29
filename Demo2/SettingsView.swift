//
//  SettingsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI




struct SettingsView: View {
    
@ObservedObject var vm: CoreDataViewModel

    var body: some View {
        
        VStack{
            
            Text("Settings").font(.title)
            
            List{
                Button {
                    withAnimation{
                        
                        vm.resetCoreData()
                        print("delete button was pressed")
                    }
                } label: {
                    Text("Reset Core Data")
                }
                
                Button {
                    withAnimation{
                        
                        vm.setIsDark(entity: vm.modeEntities[0])
                        print("swight light mode button was pressed")
                    }
                } label: {
                    Text("Switch light Mode")
                }
                
                
                
                
            }
        }.environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct SettingsViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                SettingsView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        SettingsViewContainer()
    }
}


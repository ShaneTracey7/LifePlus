//
//  SettingsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI




struct SettingsView: View {
    
@ObservedObject var vm: CoreDataViewModel
@EnvironmentObject var lightSettings: LightSettings

    
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
                        
                        lightSettings.setIsDark(switch: lightSettings.isDark)
                        print("swight light mode button was pressed")
                    }
                } label: {
                    Text("Switch light Mode")
                }
                
                
                
                
            }
        }.environment(\.colorScheme, lightSettings.isDark ? .dark : .light)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct SettingsViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                SettingsView(vm: self.vm ).environmentObject(LightSettings())
            }
        }
    
    static var previews: some View {
        SettingsViewContainer()
    }
}


//
//  HelpView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct HelpView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    
    var body: some View {
        
        VStack{
            
            Text("Help").font(.title)
            NavigationView{
                
            List{
                NavigationLink(destination: SettingsView(vm: vm)){
                    VStack{
                        Text("FAQ's").font(.body)
                    }
                }
                
                Text("Point System").font(.body)
                Text("About LifePlus").font(.body)
                Text("Settings").font(.body)
            }
        }
            
            
        }.environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        
        
    }
}

struct HelpView_Previews: PreviewProvider {
    
    struct HelpViewContainer: View {
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                HelpView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        HelpViewContainer()
    }
}

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
        NavigationView{
    
            VStack{
            
            Text("Help").font(.title).foregroundColor(Color.primary)
            
            List{
            
                NavigationLink(destination: AboutView(vm: vm)){
                    VStack{
                        Text("About LifePlus").font(.body)
                    }
                }
                NavigationLink(destination: FAQView(vm: vm)){
                    VStack{
                        Text("FAQ's").font(.body)
                    }
                }
                NavigationLink(destination: PointSystemView(vm: vm)){
                    VStack{
                        Text("Point System").font(.body)
                    }
                }
                
                NavigationLink(destination: SettingsView(vm: vm)){
                    VStack{
                        Text("Settings").font(.body)
                    }
                }
                
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

//
//  AboutView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI

struct AboutView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
       NavigationStack{
        
           
           VStack(spacing: 0){
               
               Text("About").font(.title).foregroundColor(Color.primary)
               
               if vm.modeEntities[0].isDark
               {
                   Image("logo_darkMode").resizable()
                       .frame(width: 300, height: 160)
                       .padding(.leading, 50)
               }
               else
               {
                   Image("logo").resizable()
                       .frame(width: 300, height: 160)
                       .padding(.leading, 50)
               }
               
               VStack(alignment: .leading, spacing: 10) {
                   
                   Text("Purpose").font(.title2).foregroundColor(Color.blue)
                   Text("LifePlus was designed to keep their user's on track with their tasks. The Design intends to imitate a video game, where you are rewarded for completing levels, challenges, or goals. Opposed to unlocking levels, characters, or gaining experience points, in LifePlus, you gain points to cash in for real life rewards. ").font(.body).foregroundColor(Color.secondary)
                   
                   Spacer(minLength: 30)
               }.padding(.horizontal, 15)
           }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
    }
}
        

struct AboutView_Previews: PreviewProvider {
    struct AboutViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                AboutView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        AboutViewContainer()
    }
}


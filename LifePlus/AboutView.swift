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
        
           VStack(alignment: .leading, spacing: 10) {
               
               Text("About View ").font(.title).foregroundColor(Color.primary).padding([.bottom], 20)
               
               Text("Purpose").font(.title2).foregroundColor(Color.blue)
               Text("LifePlus was designed to keep their user's on track with their tasks. The Design intends to imitate a video game, where you are rewarded for completing levels, challenges, or goals. Opposed to unlocking levels, characters, or gaining experience points, in LifePlus, you gain points to cash in for real life rewards. ").font(.body).foregroundColor(Color.secondary)
               
               
               Text("Question 2").font(.title2).foregroundColor(Color.blue)
               Text("body for question 2").font(.body).foregroundColor(Color.secondary)
               
               
               Text("Question 3").font(.title2).foregroundColor(Color.blue)
               Text("body for question 3").font(.body).foregroundColor(Color.secondary)
               
               Spacer(minLength: 30)
           }.padding(.horizontal, 15)
            
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


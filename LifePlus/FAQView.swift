//
//  FAQView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI

struct FAQView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
       NavigationStack{
        
           VStack(alignment: .leading, spacing: 10) {
               
               Text("Frequently Asked Questions").font(.title).foregroundColor(Color.primary).padding([.bottom], 20)
               
               Text("How do I reset my data?").font(.title2).foregroundColor(Color.blue)
               Text("Hit the \(Image(systemName: "gearshape")) at the top of Home Page > Settings > Press 'Erase All Data' button. This will delete your reward points, level, tasks, and rewards.").font(.body).foregroundColor(Color.secondary)

               
               Text("Question 2").font(.title2).foregroundColor(Color.blue)
               Text("body for question 2").font(.body).foregroundColor(Color.secondary)
            
               
               Text("Question 3").font(.title2).foregroundColor(Color.blue)
               Text("body for question 3").font(.body).foregroundColor(Color.secondary)
               
               Spacer(minLength: 30)
           }.padding(.horizontal, 15)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
    }
}

struct FAQView_Previews: PreviewProvider {
    struct FAQViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                FAQView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        FAQViewContainer()
    }
}


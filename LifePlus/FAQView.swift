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
        
           Text("Frequently Asked Questions").font(.title).foregroundColor(Color.primary).padding([.bottom], 20)
           
           ScrollView{
               
               VStack(alignment: .leading, spacing: 10) {
                   VStack{
                       Text("How do I reset my data?").font(.title2).foregroundColor(Color.blue)
                       Text("Hit the \(Image(systemName: "gearshape")) at the top of Home Page > Settings > Press 'Erase All Data' button. This will delete your reward points, level, tasks, and rewards in your wallet.").font(.body).foregroundColor(Color.secondary)
                   }
                       VStack{
                       Text("How do I revert back to default rewards?").font(.title2).foregroundColor(Color.blue)
                       Text("Hit the \(Image(systemName: "gearshape")) at the top of Home Page > Settings > Press 'Restore Default Rewards' button. This will delete any user added rewards and if necessary, add back any missing default rewards.").font(.body).foregroundColor(Color.secondary)
                   }
                   VStack{
                       Text("What happens when I delete a completed Task?").font(.title2).foregroundColor(Color.blue)
                       Text("When a completed task is completed, all the points awarded when the task was initially completed, gets subracted from your reward points and user points. If the task was included in a goal, the goal progress gets adjusted.").font(.body).foregroundColor(Color.secondary)
                   }
                   VStack{
                       Text("What happens when I complete a goal?").font(.title2).foregroundColor(Color.blue)
                       Text("When a completed goal is completed, you recieve the amount of points you set for the goal, that will be added to your user level and reward points. ").font(.body).foregroundColor(Color.secondary)
                   }
                   VStack{
                       Text("How do I add/delete default values for Daily, Weekly, and Monthly TODO's?").font(.title2).foregroundColor(Color.blue)
                       Text("Hit the \(Image(systemName: "gearshape")) at the top of Home Page > Settings > Update Default Tasks > Select what List you would like to update. From there, you can add and delete tasks as if it were a normal list. Then go back to the list and you'll see it populated with the updated defaults. ").font(.body).foregroundColor(Color.secondary)
                   }
                   Spacer(minLength: 30)
               }.padding(.horizontal, 15)
           }
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


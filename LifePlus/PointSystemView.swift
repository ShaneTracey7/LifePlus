//
//  PointSystemView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI

struct PointSystemView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
       NavigationStack{
        
           VStack(alignment: .leading, spacing: 10) {
               
               Text("Point System").font(.title).foregroundColor(Color.primary).padding([.bottom], 20)
               
               Text("Earning Points").font(.title2).foregroundColor(Color.blue)
               Text(" To earn points, you must complete tasks ").font(.body).foregroundColor(Color.secondary)
               
               Text("Point Calculation").font(.title2).foregroundColor(Color.blue)
               Text("The amount of points earned for a task is determined by duration of the task. You recieve a base of 100 points for any task completed, then an additional 400 points/hour of duration of task. If the task is under and hour in length or not an exact multipe of an hour, the points are awarded proportionally. For example: * a 30 minute task was completed * you are awarded 100 points(base) + 400 points x 0.5 hours (for duration), for a total of 300 points. ").font(.body).foregroundColor(Color.secondary)
               
               
               Text("Redeeming Points for Rewards").font(.title2).foregroundColor(Color.blue)
               Text("There are four reward levels for redeeming points: 2000, 4000, 8000, 16000. Once redeemed, your reward points' bar will adjust accordingly, but you user level bar, will be unchanged. ").font(.body).foregroundColor(Color.secondary)
               
               Spacer(minLength: 30)
           }.padding(.horizontal, 15)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
    }
}

struct PointSystemView_Previews: PreviewProvider {
    struct PointSystemViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                PointSystemView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        PointSystemViewContainer()
    }
}

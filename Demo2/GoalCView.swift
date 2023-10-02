//
//  GoalCView.swift
//  Demo2
//
//  Created by Coding on 2023-10-02.
//

import SwiftUI

struct GoalCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    let goal: GoalEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, and complete and delete buttons
                HStack{
                    
                    Text(goal.name ?? "No name")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width:225, alignment: .leading)
                        .padding([.leading], 20)
                        
                    Text("\(String(format: "%.2f", goal.currentValue)) / \(String(format: "%.1f", goal.value))")
                        .font(.body)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width:75, alignment: .leading)
                        .padding([.trailing], 20)
                        
                                                
                            
                    
            }//.padding([.top, .bottom], 5)
            //.border(Color.red)
                if goal.isComplete == true {
                    Text("Completed").font(.caption2).foregroundColor(Color(red: 0.30, green: 0.60, blue: 0.40))
                        .frame(alignment: .leading)
                        .padding([.leading],20)
                        .padding([.top],5)
                        //.border(Color.red)
                }
                
                HStack{
                    Gauge(value: goal.currentValue / goal.value, in: 0...1){}.tint(Gradient(colors: [.blue, .green])).frame(width: 250)
                    
                    //delete goal button
                    Button(role: .destructive,
                           action: {
                        withAnimation{
                            print("delete button was pressed")
                            doubleCheck = true
                        }
                        
                    },
                           label: {
                        Image(systemName: "trash").imageScale(.medium).foregroundColor(Color.red)
                    })
                    .frame(width: 40, height: 40).frame(alignment: .trailing).padding([.trailing],10).buttonStyle(.plain)
                    .confirmationDialog(
                    "Are you sure?",
                    isPresented: $doubleCheck,
                    titleVisibility: .visible
                )
                    {
                        Button("Yes", role: .destructive)
                        {
                if goal.isComplete
                {
                    //remove points for deleting a completed goal
                    let remove: Int = Int(goal.completedPoints)
                    let pointsValue: Int = Int(vm.pointEntities[0].value)
                    let rewardPointsValue: Int = Int(vm.pointEntities[1].value)
                    
                    if remove > pointsValue
                    {
                        // setting points to zero
                        vm.addPoints(entity: vm.pointEntities[0], increment: (pointsValue * (-1)))
                    }
                    else
                    {   // removing the amount of points the task was worth
                        vm.addPoints(entity: vm.pointEntities[0], increment: (remove * (-1)))
                    }
                    
                    if remove > rewardPointsValue
                    {
                        // setting points to zero
                        vm.addPoints(entity: vm.pointEntities[1], increment: (rewardPointsValue * (-1)))
                    }
                    else
                    {   // removing the amount of points the task was worth
                        vm.addPoints(entity: vm.pointEntities[1], increment: (remove * (-1)))
                    }
                    
                }
                let index = vm.goalEntities.firstIndex(of:goal)
                vm.deleteGoal(index: index ?? 0)
                print("confirmation delete button was pressed")
            }
                        Button("No", role: .cancel){}
            
                    }
                }.padding([.leading], 25)
                
                
            // contains date and duration
            HStack{
                Text("Start: \((goal.startDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    .frame(width: 125, alignment: .leading)
                    .padding([.leading],20)
                
                Text("End: \((goal.endDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    .frame(width: 125, alignment: .leading)
                    .padding([.leading],20)
                
            }
            //.padding([.top, .bottom], 5)
            //.border(Color.red)
            
        }.frame(width:350)
        //.border(Color.green)
        
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 40)
                }
                
                .foregroundColor(Color(red: 0.65, green: 0.75, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
            .padding([.top], 5)
    
        }.frame(width: 410.0)//.border(Color.blue)
    }
}


struct GoalCView_Previews: PreviewProvider {
    
    struct GoalCViewContainer: View {
        @State var vm = CoreDataViewModel()
        let goal: GoalEntity = GoalEntity()
        
            var body: some View {
                GoalCView(vm: self.vm, goal: goal)
                
            }
        }
    
    static var previews: some View {
        GoalCViewContainer()
    }
}


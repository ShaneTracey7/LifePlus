//
//  BasicStepView.swift
//  LifePlus
//
//  Created by Coding on 2024-08-01.
//

import SwiftUI

struct BasicStepView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    @State var optionalStep: StepEntity?
    
    @Binding var goal: GoalEntity
    @Binding var stepArr: [StepEntity]
    @Binding var sortSelection: Int
    @Binding var editOn: Bool
    
    let step: StepEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                //contains name, and complete and delete buttons
                HStack{
                    
                    //not defaulttask or complete task
                    if editOn && !step.isComplete
                    {
                        
                        NavigationLink(destination: AddStepView(vm: self.vm, goal: $goal, step: $optionalStep)){

                                    Text(step.name ?? "No name")
                                        .font(.body)//.font(.title3)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .frame(alignment: .leading)
                                        .padding([.leading], 15)
                                        .padding([.top], 0)
                            }
                            .buttonStyle(PressableButtonStyle())
                            .padding([.trailing], 5)
                            
                            Spacer()
                    }
                    else
                        {
                    
                        Text(step.name ?? "No name")
                            .font(.body)//.font(.title3)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(alignment: .leading)
                            .padding([.leading], 15)
                        
                        Spacer()
                        
                    }
            
                       if step.isComplete == false {
                           
                           //task complete button
                           Button {
                               print("complete button was pressed")
                               withAnimation {
                                   step.isComplete.toggle()
                               }
                               //reset sorting in tasklistview
                               
                               step.isComplete = true
                               
                               //change backgroundcolor
                               lightColorChange = Library.lightgreenColor
                               colorChange = Library.greenColor
                               
                               //check if this completes the list
                               vm.goalCompleteChecker(goal: goal)
                               
                               //update goal
                               goal.completedSteps = goal.completedSteps + 1
                               vm.saveGoalData()
                               
                           } label: {
                               Image(systemName: "checkmark.circle").imageScale(.medium).foregroundColor(Library.lightgreenColor)
                           }
                           .frame(width: 20, height: 35)
                           .frame(alignment: .trailing).buttonStyle(.plain)
                           .padding([.trailing],5)
                           
                       }
                       else{
                           //undo button
                           Button {
                               print("undo button was pressed")
                               withAnimation {
                                   //task.isComplete.toggle() //idk what this does
                               }
                               //reset sorting in tasklistview
                               sortSelection = 0
                               
                               goal.isComplete = false
                               step.isComplete = false
                               
                               //change backgroundcolor (may have to take in consideration if task is past due (would be red)
                               let td = Library.firstSecondOfToday()
                               
                               if step.endDate ?? Date() < td
                               {
                                   lightColorChange = Library.lightredColor
                                   colorChange = Library.redColor
                               }
                               else
                               {
                                   lightColorChange = Library.lightblueColor
                                   colorChange = Library.blueColor
                               }
                               
                               //sets list as incomplete
                               vm.goalNotComplete(goal: goal)
                               
                               if goal.isComplete
                               {
                                   let sub: Int = Int(goal.completedPoints * (-1))
                                   vm.addPoints(entity: vm.pointEntities[0], increment: sub)
                                   vm.addPoints(entity: vm.pointEntities[1], increment: sub)
                               }
                               
                               //update goal
                               goal.completedSteps = goal.completedSteps - 1
                               vm.saveGoalData()
                               
                           } label: {
                               Image(systemName: "arrow.uturn.right.circle").imageScale(.medium).foregroundColor(Color.blue)
                           }
                           .frame(width: 20, height: 35)
                           .frame(alignment: .trailing).buttonStyle(.plain)
                           .padding([.trailing],5)
                           //Spacer().frame(width: 20, height: 35)
                   }
        
                        //delete task button
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
                        .frame(width: 20, height: 35).frame(alignment: .trailing).padding([.trailing],12).buttonStyle(.plain)
                        .confirmationDialog(
                            "Are you sure?",
                            isPresented: $doubleCheck,
                            titleVisibility: .visible
                        )
                        {
                            Button("Yes", role: .destructive)
                            {
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                //update goal
                                if step.isComplete
                                {
                                    goal.completedSteps = goal.completedSteps - 1
                                }
                                goal.steps = goal.steps - 1
                                
                                let index = vm.stepEntities.firstIndex(of: step)
                                vm.deleteStep(index: index ?? 0)
                                
                                //remove task from stepArr
                                let arrIndex = stepArr.firstIndex(of: step) ?? -1
                                if arrIndex != -1
                                {
                                    stepArr.remove(at: arrIndex)
                                }
                                else
                                {
                                    print("error removing from stepArr")
                                }
                                
                                vm.goalCompleteChecker(goal: goal)
                                vm.saveGoalData()
                                
                                print("confirmation delete button was pressed")
                            }
                            Button("No", role: .cancel){}
                            
                        }
                    
            }.padding([.trailing], 5)
            //.border(Color.red)
                
                    Spacer().frame(height:20)
                
            // contains date and duration
            
            }/*.frame(width:350)*/.frame(maxWidth: .infinity)
        //.border(Color.green)
        
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 40)
                }
                
                .foregroundColor(colorChange)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
    
        }
        /*.frame(width: 410.0)*/.frame(maxWidth: .infinity).padding([.horizontal],20)//.border(Color.blue)
        .onAppear{

            optionalStep = step
            
            let td = Library.firstSecondOfToday()
            
                //complete
                if step.isComplete
                {
                    lightColorChange = Library.lightgreenColor
                    colorChange = Library.greenColor
                }
                else if step.endDate ?? Date() < td
                {
                lightColorChange = Library.lightredColor
                colorChange = Library.redColor
                }
                else
                {
                    lightColorChange = Library.lightblueColor
                    colorChange = Library.blueColor
                }
            }
        }
    }


struct BasicStepView_Previews: PreviewProvider {
    
    struct BasicStepViewContainer: View {
        @State var vm = CoreDataViewModel()

        @State var goal: GoalEntity = GoalEntity()
        @State var stepArr: [StepEntity] = []
        @State var sortSelection: Int = 0
        @State var editOn: Bool =  false
        let step: StepEntity = StepEntity()
            
            var body: some View {
                BasicStepView(vm: self.vm, goal: $goal, stepArr: $stepArr, sortSelection: $sortSelection, editOn: $editOn, step: step)
                
            }
        }
    
    static var previews: some View {
        BasicStepViewContainer()
    }
}

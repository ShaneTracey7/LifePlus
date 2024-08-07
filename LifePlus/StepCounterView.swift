//
//  StepCounterView.swift
//  LifePlus
//
//  Created by Coding on 2024-08-07.
//

import SwiftUI

struct StepCounterView: View {
   
   @ObservedObject var vm: CoreDataViewModel
   @State var doubleCheck: Bool = false
   
   // for changing colors to show state of list (complete or normal)
   @State var colorChange: Color = Color.black
   @State var lightColorChange: Color = Color.black
   @State var currentReps: Int = 0
   @State var dummyValue: Int = 0
   @State var optionalStep: StepEntity?
   @State var steplist: StepEntity = StepEntity() //NEEDED FOR addstepliststepview
   @State var inCalendar: Bool = false
   
   @Binding var sortSelection: Int
   @Binding var showPopUp: Bool
   @Binding var namePopUp: String
   @Binding var infoPopUp: String
   @Binding var goal: GoalEntity
   @Binding var stepArr: [StepEntity]
   @Binding var editOn: Bool
   
   let step: StepEntity
   
   var body: some View {
       
       ZStack{
           // combines
           VStack(alignment: .leading, spacing: 0){
               
               //contains name, stepper, and complete and delete buttons
               HStack{
                   //edit is on and step isn't complete
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
                                       
                       MyStepper(value: $currentReps, in:  0...Int(step.totalReps), inCalendar: $inCalendar)
                           .padding([.trailing], 5)
                           .onChange(of: currentReps) { newValue in
                                                              
                               step.currentReps = Int32(newValue)
                               vm.saveStepData()
                               
                               if newValue == Int(step.totalReps)
                               {
                                   if step.isComplete
                                   {
                                       // do nothing
                                   }
                                   else
                                   {
                                       //reset sorting in tasklistview
                                       sortSelection = 0
                                       
                                       step.isComplete = true
                                       
                                       //change backgroundcolor
                                       lightColorChange = Library.lightgreenColor
                                       colorChange = Library.greenColor
                                    
                                       goal.completedSteps = goal.completedSteps + 1
                                       
                                       //check if this completes the list
                                       vm.goalCompleteChecker(goal: goal)
                                       
                                       if goal.isComplete
                                       {
                                           let add: Int = Int(goal.completedPoints)
                                           vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                           vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                       }
                                   }
                               }
                               else
                               {
                                   if step.isComplete
                                   {
                                       step.isComplete = false
                                       
                                       //change backgroundcolor
                                       if step.endDate ??  Date() < Library.firstSecondOfToday()
                                       {
                                           lightColorChange = Library.lightredColor
                                           colorChange = Library.redColor
                                       }
                                       else
                                       {
                                           lightColorChange = Library.lightblueColor
                                           colorChange = Library.blueColor
                                       }
                                       
                                       //subtract points
                                       let sub: Int = Int(goal.completedPoints * (-1))
                                       vm.addPoints(entity: vm.pointEntities[0], increment: sub)
                                       vm.addPoints(entity: vm.pointEntities[1], increment: sub)
                                       
                                       goal.completedSteps = goal.completedSteps - 1
                                       
                                       vm.goalCompleteChecker(goal: goal)
                                       
                                   }
                                   else
                                   {
                                       //do nothing
                                   }
                                   //reset sorting in tasklistview
                                   sortSelection = 0
                               }
                           }
                   Button(action: {
                       
                       namePopUp = step.name ?? ""
                       infoPopUp = step.info ?? ""
                       showPopUp = true
                   }, label: {
                       
                       Image(systemName: "note.text")
                           .font(.title3)
                           .foregroundColor(Color.white)
                   })
                   .buttonStyle(PressableButtonStyle())
                   .frame(width:20, height: 35)
                   .padding([.trailing],5)
                   
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
                       .frame(width: 20, height: 35).frame(alignment: .trailing).padding([.trailing],15).buttonStyle(.plain)
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
                               
                               if step.isComplete
                               {
                                   goal.completedSteps = goal.completedSteps - 1
                                   goal.steps = goal.steps - 1
                               }
                               else
                               {
                                   goal.steps = goal.steps - 1
                               }
                               let index = vm.stepEntities.firstIndex(of: step)
                               vm.deleteStep(index: index ?? 0)
                               
                               //remove task from taskArr
                               let arrIndex = stepArr.firstIndex(of: step) ?? -1
                               if arrIndex != -1
                               {
                                   stepArr.remove(at: arrIndex)
                               }
                               else
                               {
                                   print("error removing from taskArr")
                               }
                               
                               vm.goalCompleteChecker(goal: goal)
                               
                               if goal.isComplete
                               {
                                   let add: Int = Int(goal.completedPoints)
                                   vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                   vm.addPoints(entity: vm.pointEntities[1], increment: add)
                               }
                               
                               print("confirmation delete button was pressed")
                           }
                           Button("No", role: .cancel){}
                           
                       }
                   
               }.padding([.trailing], 5)
               //.border(Color.red)
               
            
                   if step.isComplete == true {
                       Text("Completed").font(.caption2).foregroundColor(Color.green)
                           .frame(alignment: .leading)
                           .padding([.leading],15)
                           .padding([.top],5)
                       //.border(Color.red)
                   }
                   else if step.endDate ??  Date() < Library.firstSecondOfToday() //implement past due
                   {
                       Text("Past Due").font(.caption2).foregroundColor(Color.red)
                           .frame(alignment: .leading)
                           .padding([.leading],15)
                           .padding([.top],5)
                   }
                   else
                    {
                       Spacer().frame(height:20)
                   }
               
               HStack{
                   
                    Gauge(value:  Float(step.currentReps)/Float(step.totalReps),in: 0...1){}.tint(Gradient(colors: [.red, .blue]))
                    Spacer()
                    Text(" \(step.currentReps) / \(step.totalReps)").foregroundColor(Color.white).font(.callout)
                   
               }.padding([.leading, .trailing], 15)
               
               // contains date and duration
               HStack{

                    Text("Due: \((step.endDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                       .font(.callout) //.font(.body)
                       .foregroundColor(lightColorChange)
                       .frame(alignment: .leading)
                       .padding([.leading],15)

                   Spacer()
                   
                   if (step.duration > 119)
                   {
                       let quotient = Double (step.duration) / 60
                       Text("\(String(format: "%.1f", quotient)) hours")
                           .font(.callout) //.font(.body)
                       //.padding([.trailing],10)
                           .foregroundColor(lightColorChange)
                           .frame(width: 100)
                   }
                   else
                   {
                       Text("\(step.duration) mins").font(.callout) //.font(.body)
                       //.padding([.trailing],10)
                           .foregroundColor(lightColorChange).frame(width: 100)
                   }
                   
               }
               //.padding([.top, .bottom], 5)
               //.border(Color.red)
               
           }/*.frame(width: 350)*/.frame(maxWidth: .infinity)
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
           
           currentReps = Int(step.currentReps)
           
               let td = Library.firstSecondOfToday()
               
               //complete
               if step.isComplete
               {
                   lightColorChange = Library.lightgreenColor
                   colorChange = Library.greenColor
               }
               //past due
               else if step.endDate ?? Date() < td
               {
                   lightColorChange = Library.lightredColor
                   colorChange = Library.redColor
               }
               //default
               else
               {
                   lightColorChange = Library.lightblueColor
                   colorChange = Library.blueColor
               }
           }
       }
   }

struct StepCounterView_Previews: PreviewProvider {

struct StepCounterViewContainer: View {
@State var vm = CoreDataViewModel()
@State var sortSelection: Int = 0
@State var showPopUp: Bool = false
@State var namePopUp: String = ""
@State var infoPopUp: String = ""
@State var totalReps: Int = 0
@State var goal: GoalEntity = GoalEntity()
@State var stepArr: [StepEntity] = []
@State var editOn: Bool =  false

let step: StepEntity = StepEntity()

var body: some View {
    StepCounterView(vm: self.vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, goal: $goal, stepArr: $stepArr, editOn: $editOn, step: step)

}
}

static var previews: some View {
    StepCounterViewContainer()
}
}

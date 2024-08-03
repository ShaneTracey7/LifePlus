//
//  StepCView.swift
//  LifePlus
//
//  Created by Coding on 2024-07-22.
//
import SwiftUI

struct StepCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var doubleCheck: Bool = false
    
    // for changing colors to show state of list (complete or normal)
    @State var colorChange: Color = Color.black
    @State var lightColorChange: Color = Color.black
    @State var optionalStep: StepEntity?
    @State var steplist: StepEntity = StepEntity() //NEEDED FOR addstepliststepview
    
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
                //contains name, and complete and delete buttons
                HStack{
                                    
                    //edit is on and step isn't complete
                if editOn && !step.isComplete
                {
                    if step.listId == step.id //not in a steplist
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
                    }
                    else // in a steplist
                    {
                        NavigationLink(destination: AddStepListStepView(vm: self.vm, goal: $goal, steplist: $steplist, step: $optionalStep)){

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
                    }
                    
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
                            
                            //step complete button
                            Button {
                                print("complete button was pressed")
                                withAnimation {
                                    step.isComplete.toggle()
                                }
                                //reset sorting in tasklistview
                                sortSelection = 0
                                
                                step.isComplete = true
                                
                                //change backgroundcolor
                                lightColorChange = Library.lightgreenColor
                                colorChange = Library.greenColor
                                
                                
                                if step.listId == step.id //not in steplist
                                {
                                    //check if this completes the list
                                    vm.goalCompleteChecker(goal: goal)
                                    
                                    //update goal
                                    goal.completedSteps = goal.completedSteps + 1
                                    
                                    if goal.isComplete
                                    {
                                        let add: Int = Int(goal.completedPoints)
                                        vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                        vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                    }
                                }
                                else // in steplist
                                {
                                    //check if this completes the list
                                    if vm.steplistCompleteChecker(steplist: steplist)
                                    {
                                        //check if this completes the list
                                        vm.goalCompleteChecker(goal: goal)
                                        
                                        //update goal
                                        goal.completedSteps = goal.completedSteps + 1
                                        
                                        if goal.isComplete
                                        {
                                            let add: Int = Int(goal.completedPoints)
                                            vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                            vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                        }
                                    }
                                    //update steplist
                                    steplist.currentReps = steplist.currentReps + 1
                                }
                                
                                vm.saveStepData()
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
                                
                                if goal.isComplete
                                {
                                    let sub: Int = Int(goal.completedPoints * (-1))
                                    vm.addPoints(entity: vm.pointEntities[0], increment: sub)
                                    vm.addPoints(entity: vm.pointEntities[1], increment: sub)
                                }
                                                               
                                if step.listId == step.id //not in steplist
                                {
                                    //update goal
                                    goal.completedSteps = goal.completedSteps - 1
                                    
                                }
                                else // in steplist
                                {
                                    if steplist.isComplete
                                    {
                                        //update goal
                                        goal.completedSteps = goal.completedSteps - 1
                                    }
                                    //update steplist
                                    steplist.currentReps = steplist.currentReps - 1
                                    
                                    steplist.isComplete = false
                                }
                                
                                //sets goal and steplist as incomplete
                                vm.goalNotComplete(goal: goal)
                                
                                step.isComplete = false
                                
                                vm.saveGoalData()
                                vm.saveStepData()
                                
                            } label: {
                                Image(systemName: "arrow.uturn.right.circle").imageScale(.medium).foregroundColor(Color.blue)
                            }
                            .frame(width: 20, height: 35)
                            .frame(alignment: .trailing).buttonStyle(.plain)
                            .padding([.trailing],5)
                            
                            //Spacer(minLength: 40).frame(alignment: .trailing)
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
                    .padding([.trailing], 5 /*vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: steplist)*/)
                    

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
                            
                            if step.listId == step.id //not in steplist
                            {
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
                                
                                if goal.isComplete
                                {
                                    vm.goalCompleteChecker(goal: goal)
                                    if !goal.isComplete
                                    {
                                        //sub points
                                        let sub: Int = Int(goal.completedPoints * (-1))
                                        vm.addPoints(entity: vm.pointEntities[0], increment: sub)
                                        vm.addPoints(entity: vm.pointEntities[1], increment: sub)
                                    }
                                }
                                else
                                {
                                    vm.goalCompleteChecker(goal: goal)
                                    if goal.isComplete
                                    {
                                        //add points
                                        let add: Int = Int(goal.completedPoints)
                                        vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                        vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                    }
                                }
                            }
                            else // in steplist
                            {
                                //update steplist
                                if step.isComplete
                                {
                                    steplist.currentReps = steplist.currentReps - 1
                                }
                                steplist.totalReps = steplist.totalReps - 1
                                
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
                                
                                if steplist.isComplete
                                {
                                    if !vm.steplistCompleteChecker(steplist: steplist)
                                    {
                                        if goal.isComplete
                                        {
                                            vm.goalCompleteChecker(goal: goal)
                                            
                                            //sub points
                                            let sub: Int = Int(goal.completedPoints * (-1))
                                            vm.addPoints(entity: vm.pointEntities[0], increment: sub)
                                            vm.addPoints(entity: vm.pointEntities[1], increment: sub)
                                        }
                                        
                                        goal.completedSteps = goal.completedSteps - 1
                                    }

                                }
                                else
                                {
                                    if vm.steplistCompleteChecker(steplist: steplist)
                                    {
                                        //check if goal is complete
                                        vm.goalCompleteChecker(goal: goal)
                                        if goal.isComplete
                                        {
                                            //add points
                                            let add: Int = Int(goal.completedPoints)
                                            vm.addPoints(entity: vm.pointEntities[0], increment: add)
                                            vm.addPoints(entity: vm.pointEntities[1], increment: add)
                                        }
                                        goal.completedSteps = goal.completedSteps + 1
                                    }
                                }
                            }
                        
                            vm.saveStepData()
                            vm.saveGoalData()
                            
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
                    else if step.endDate ??  Date() < Library.firstSecondOfToday()//implement past due
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
            
            steplist = vm.getSteplist(goal: goal, step: step)
            
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


struct StepCView_Previews: PreviewProvider {
    
    struct StepCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var showPopUp: Bool = false
        @State var namePopUp: String = ""
        @State var infoPopUp: String = ""
        @State var goal: GoalEntity = GoalEntity()
        @State var step: StepEntity = StepEntity()
        @State var stepArr: [StepEntity] = []
        @State var editOn: Bool =  false

            
            var body: some View {
                StepCView(vm: self.vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, goal: $goal, stepArr: $stepArr, editOn: $editOn, step: step)
                
            }
        }
    
    static var previews: some View {
        StepCViewContainer()
    }
}

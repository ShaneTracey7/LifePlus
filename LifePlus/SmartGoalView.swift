//
//  SmartGoalView.swift
//  LifePlus
//
//  Created by Coding on 2024-07-22.
//
import SwiftUI

struct SmartGoalView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    //@State var doubleCheck: Bool = false
    @State var sortSelection: Int = 0
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    @State var editOn: Bool = false /*new*/
    @State var optionalStep: StepEntity? = nil
    @State var goalSInfo: String = ""
    @State var goalRInfo: String = ""
    
    @Binding var goal: GoalEntity
    
    @State var stepArr: [StepEntity] = []
    
    var body: some View {
        
        ZStack{
        
            NavigationStack{
                
                ScrollView{
                    
                    VStack{
                        
                        /*
                        // TESTING
                        Text("Step Count" + vm.testCount())
                            .font(.title2)
                            .foregroundColor(Color.secondary)
                            .padding([.bottom], 1)
                        */
                        Text("Specific")
                            .font(.title2)
                            .foregroundColor(Color.secondary)
                            .padding([.bottom], 1)
                        
                        if editOn {
                        
                            TextEditor(text: $goalSInfo)
                                .frame(height: 135)
                                .frame(width: 325)
                                .font(.body)
                                .foregroundStyle(Color.primary)
                                .border(Color.secondary)
                        }
                        else
                        {
                            Text(goal.infoS ?? " no description")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .foregroundColor(Color(light: Library.customBlue2, dark: Color.blue))
                                .frame(maxHeight: 135)
                                .frame(width: 325)
                        }
                        HStack{
                            Text("Achievable")
                                .font(.title2)
                                .foregroundColor(Color.secondary)
                                .padding([.bottom], 1)
                                .padding([.leading], 35)
                            Image(systemName: "checkmark.circle.fill").font(.title).foregroundColor(Color.green)
                            
                        }
                        Text("Relevant")
                            .font(.title2)
                            .foregroundColor(Color.secondary)
                            .padding([.bottom], 1)
                        
                        if editOn {
                            
                            TextEditor(text: $goalRInfo)
                                .frame(height: 135)
                                .frame(width: 325)
                                .font(.body)
                                .foregroundStyle(Color.primary)
                                .border(Color.secondary)
                                .padding([.bottom], 1)
                        }
                        else
                        {
                            Text(goal.infoR ?? " no description")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .foregroundColor(Color(light: Library.customBlue2, dark: Color.blue))
                                .frame(maxHeight: 135)
                                .frame(width: 325)
                                .padding([.bottom], 1)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Measurable & Time-bound")
                        .font(.title2)
                        .foregroundColor(Color.secondary)
                        .padding([.bottom], 1)
                    
                        if stepArr == [] // try nil next
                        {
                            Text("There are no steps").frame(maxWidth: .infinity).foregroundColor(Color.blue).padding([.top], 50)
                        }
                        else
                        {
                            ForEach(stepArr) { step in
                                
                                //list
                                if step.id != step.listId
                                {
                                    StepListCView(vm: vm, sortSelection: $sortSelection, editOn: $editOn, stepArr: $stepArr, goal: goal, step: step).padding([.bottom], 5)
                                }
                                //is basic step
                                else if step.duration == 0
                                {
                                    BasicStepView(vm: vm, goal: $goal, stepArr: $stepArr, sortSelection: $sortSelection, editOn: $editOn, step: step).padding([.bottom], 5)
                                }
                                // is counter
                                else if step.totalReps > 1
                                {
                                   StepCounterView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, goal: $goal, stepArr: $stepArr, editOn: $editOn, step: step)
                                }
                                //step
                                else
                                {
                                    StepCView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, goal: $goal, stepArr: $stepArr, editOn: $editOn,step: step)
                                }
                            
                            }
                        }
                    }
                }
            .navigationTitle(goal.name ?? "no name")
                .toolbar {
                    
                    
                    //edit tasks button
                    Button {
                        print("edit button was pressed")
                        withAnimation {
                            
                        }
                        //toggle editOn
                        editOn.toggle()
                        
                        if !editOn
                        {
                            //check to see if info changed
                            if goal.infoS != goalSInfo{
                                
                                if goalSInfo.count > 150
                                {
                                    goalSInfo = goal.infoS ?? "error"
                                    //(maybe an error message)
                                }
                                else
                                {
                                    //update goal info
                                    goal.infoS = goalSInfo
                                    vm.saveGoalData()
                                }

                            }
                            if goal.infoR != goalRInfo{
                                
                                if goalRInfo.count > 150
                                {
                                    goalRInfo = goal.infoR ?? "error"
                                    //(maybe an error message)
                                }
                                else
                                {
                                    //update goal info
                                    goal.infoR = goalRInfo
                                    vm.saveGoalData()
                                }
                            }
                        }
                        
                    } label: {
                        Image(systemName: "pencil.circle").foregroundColor(editOn ? Color.red : Color(light: Color.black, dark: Color.white))
                    }
                    //.frame(width: 20, height: 35)
                    .frame(alignment: .trailing).buttonStyle(.plain)
                    //.padding([.trailing],5)
                    
                    NavigationLink(destination: AddStepView(vm: self.vm, goal: $goal, step: $optionalStep)){
                            Image(systemName: "plus")
                        }
                    }
                
                /*
                if goal.steps == 0
                {
                    Text("There are no steps").frame(maxWidth: .infinity).foregroundColor(Color.blue)
                }
                 */
            
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear
            {
               //get array of steps
                stepArr = vm.getStepArr(goal: goal)
                
                //set goalInfo for edit mode
                goalSInfo = goal.infoS ?? "error"
                goalRInfo = goal.infoR ?? "error"
            }
        }
    }
    
struct SmartGoalView_Previews: PreviewProvider {
    
    struct SmartGoalViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var goal = GoalEntity()
            var body: some View {
                SmartGoalView(vm: vm, goal: $goal)
            }
        }
    
    static var previews: some View {
        SmartGoalViewContainer()
        
    }
}


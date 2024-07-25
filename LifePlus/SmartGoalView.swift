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
    @State var goalInfo: String = ""
    
    @Binding var goal: GoalEntity
    
    @State var stepArr: [StepEntity] = []
    
    var body: some View {
        
        ZStack{
        
            NavigationStack{
                
                ScrollView{
                    
                    if editOn {
                        
                        //figure out a fix for this
                        TextEditor(text: $goalInfo)
                                .frame(height: 135)
                                .font(.body)
                                .foregroundStyle(Color.primary)
                                .border(Color.secondary)
                    }
                    else
                    {
                        Text(goal.info ?? " no description")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                            .foregroundColor(Color(light: Library.customBlue2, dark: Color.blue))
                            .frame(height:200)
                    }
                    
                    Spacer()
                    
                        if stepArr == [] // try nil next
                        {
                            // do nothing
                        }
                        else
                        {
                            ForEach(stepArr) { step in
                                
                                StepCView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, goal: $goal, stepArr: $stepArr, editOn: $editOn,step: step)
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
                            if goal.info != goalInfo{
                                goal.info = goalInfo
                                //make proper changes to save 
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
                    
                if goal.steps == 0
                {
                    Text("Please add a step").frame(maxWidth: .infinity).foregroundColor(Color.blue)
                }
            
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear
            {
               //get array of steps
                stepArr = vm.getStepArr(goal: goal)
                
                //set goalInfo for edit mode
                goalInfo = goal.info ?? "error"
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

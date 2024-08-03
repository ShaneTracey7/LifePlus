//
//  StepListView.swift
//  LifePlus
//
//  Created by Coding on 2024-08-02.
//

import SwiftUI

struct StepListView: View {
    
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
    //let steplist: StepEntity
    @State var steplist: StepEntity
    
    @State var stepArr: [StepEntity] = []
    
    var body: some View {
        
        ZStack{
        
            NavigationStack{
                
                ScrollView{
                    
                    Spacer()
                    
                    
                        if stepArr == [] // try nil next
                        {
                            Text("There are no steps").frame(maxWidth: .infinity).foregroundColor(Color.blue).padding([.top], 50)
                        }
                        else
                        {
                            ForEach(stepArr) { step in
                                
                                //is basic step
                                if step.duration == 0
                                {
                                    BasicStepView(vm: vm, goal: $goal, stepArr: $stepArr, sortSelection: $sortSelection, editOn: $editOn, step: step).padding([.bottom], 5)
                                }
                                // is counter
                                else if step.totalReps > 1
                                {
                                        // implement counter
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
            .navigationTitle(steplist.name ?? "no name")
                .toolbar {
                    
                    
                    //edit tasks button
                    Button {
                        print("edit button was pressed")
                        withAnimation {
                            
                        }
                        //toggle editOn
                        editOn.toggle()
                        
                    } label: {
                        Image(systemName: "pencil.circle").foregroundColor(editOn ? Color.red : Color(light: Color.black, dark: Color.white))
                    }
                    //.frame(width: 20, height: 35)
                    .frame(alignment: .trailing).buttonStyle(.plain)
                    //.padding([.trailing],5)
                                                                                //optionalStep could be an issue
                    NavigationLink(destination: AddStepListStepView(vm: self.vm, goal: $goal, steplist: $steplist, step: $optionalStep)){
                            Image(systemName: "plus")
                        }
                    }
                
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear
            {
               //get array of steps in steplist
                stepArr = vm.getStepListArr(goal: goal, steplist: steplist)
                
            }
        }
    }
    
struct StepListView_Previews: PreviewProvider {
    
    struct StepListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var goal = GoalEntity()
        @State var steplist = StepEntity()
            var body: some View {
                StepListView(vm: vm, goal: $goal, steplist: steplist)
            }
        }
    
    static var previews: some View {
        StepListViewContainer()
        
    }
}



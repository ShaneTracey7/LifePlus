//
//  StepListCView.swift
//  LifePlus
//
//  Created by Coding on 2024-08-01.
//
import SwiftUI

struct StepListCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @Binding var sortSelection: Int
    @Binding var editOn: Bool
    
    @State var doubleCheck: Bool = false
    @State var optionalStep: StepEntity?
    @State var goal: GoalEntity
    
    let step: StepEntity
    
    var body: some View {
        
        ZStack{
            
            // combines
            VStack(alignment: .leading, spacing: 0){
                
                HStack{
                    
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
                        NavigationLink(destination: SmartGoalView(vm: vm, goal: $goal)){
                            
                            Text(step.name ?? "No name")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .padding([.leading], 15)
                                .multilineTextAlignment(.leading)
                        }
                        .buttonStyle(PressableButtonStyle())
                        .padding([.trailing], 5)
                        
                        Spacer()
                    }
                                                        
                }.padding([.trailing], 20)
        
                HStack{

                if step.isComplete{
                    Text("Completed").font(.caption2).foregroundColor(Color(red: 0.30, green: 0.60, blue: 0.40))
                        .frame(alignment: .leading)
                        .padding([.leading],20)
                        .padding([.top],5)
                    //.border(Color.red)
                }
                
                else if (step.endDate ?? Date()) < Date(){
                    Text("Past Due").font(.caption2).foregroundColor(Color.red)
                        .frame(alignment: .leading)
                        .padding([.leading],20)
                        .padding([.top],5)
                    //.border(Color.red)
                }
                
                else
                {
                    Spacer().frame(width: 85,height: 20)
                }
                    Spacer().frame(minWidth: 50, maxWidth: 120)
                    
                    Text("\(String(format: "%.1f", step.currentReps)) / \(String(format: "%.1f", step.totalReps))")
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 100,alignment: .trailing)
                            //.border(Color.red)
                            //.frame(maxWidth: 100)
                            //.padding([.trailing], 5)
                            
                           
                                Text("steps")
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .frame(width:40, alignment: .leading)
                                    .padding([.trailing], 20)
                                // .border(Color.red)
                            
            }
                HStack{
                    Gauge(value: Float(step.currentReps) / Float(step.totalReps), in: 0...1){}.tint(Gradient(colors: [.blue, .green])).frame(width: 250)
                    
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
                            
                        //reset sorting in goalview
                        sortSelection = 0
                            
                            //implement function to delete steplist step ans all the steps in the list
                        //let index = vm.goalEntities.firstIndex(of:goal)
                        //vm.deleteGoal(index: index ?? 0)
                        print("confirmation delete button was pressed")
            }
                        Button("No", role: .cancel){}
            
                    }
                }.padding([.leading], 25)
                
                
            // contains date and duration
            HStack{
                Text("Start: \((step.startDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    .frame(width: 125, alignment: .leading)
                    .padding([.leading],30)
                
                Text("End: \((step.endDate ?? Date()).formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.78, green: 0.90, blue: 1.14))
                    .frame(width: 125, alignment: .leading)
                    .padding([.leading],30)
                
            }
            //.padding([.top, .bottom], 5)
            //.border(Color.red)
            
        }
        //.border(Color.green)
            .frame(width:350, height: 110)
            .background{
                ZStack(alignment: .top) {
                    Rectangle().opacity(0.7)
                    Rectangle().frame(maxHeight: 50)
                }
                
                .foregroundColor(Color(red: 0.65, green: 0.75, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 4, y: 4
                )
            }
            .padding([.top], 5)
    
        }.frame(maxWidth: .infinity).padding([.horizontal],20)//.frame(width: 410.0)//.border(Color.blue)
            .onAppear{
                
            optionalStep = step
        }
    }
}


struct StepListCView_Previews: PreviewProvider {
    
    struct StepListCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        @State var editOn: Bool =  false
        let goal: GoalEntity = GoalEntity()
        let step: StepEntity = StepEntity()
            var body: some View {
                StepListCView(vm: self.vm, sortSelection: $sortSelection,editOn: $editOn, goal: goal, step: step)
            }
        }
    
    static var previews: some View {
        StepListCViewContainer()
    }
}


//
//  AddGoalView.swift
//  Demo2
//
//  Created by Coding on 2023-10-02.
//

import SwiftUI

struct AddGoalView: View {
    @ObservedObject var vm: CoreDataViewModel
    @State private var goalName: String = ""
    @State private var isHours: Bool
    @State private var value: Int = 0
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var completedPoints: Int = 0
    let choices = ["# of Tasks", "Duration of Tasks"]
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("Goal Description"){

                            TextField("Name of Goal", text: $goalName)
                                .frame(width:300)
                                .font(.title2)
                                .cornerRadius(25)
                                .padding([.top], 25)
                                .foregroundColor(Color.primary)
                            
                            
                            Picker(selection: $isHours, label: Text("Measure"))
                            {
                                Text("\(0)").tag(0)
                                ForEach(choices, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            if isHours {
                                TextField("Duration of Tasks", text: $value)
                                    .frame(width:300)
                                    .font(.title2)
                                    .cornerRadius(25)
                                    .padding([.top], 25)
                                    .foregroundColor(Color.primary)
                            }
                            else
                            {
                                TextField("# of Tasks", text: $value)
                                    .frame(width:300)
                                    .font(.title2)
                                    .cornerRadius(25)
                                    .padding([.top], 25)
                                    .foregroundColor(Color.primary)
                            }
                            
                            TextField("Points awarded", text: $completedPoints)
                                .frame(width:300)
                                .font(.title2)
                                .cornerRadius(25)
                                .padding([.top], 25)
                                .foregroundColor(Color.primary)
                            
                            
                            HStack{
                                DatePicker(
                                    "Start Date",
                                    selection: $startDate,
                                    displayedComponents: [.date]
                                )
                                .frame(width:300, height: 75)
                                .foregroundColor(Color.primary)
                                
                                DatePicker(
                                    "End Date",
                                    selection: $endDate,
                                    displayedComponents: [.date]
                                )
                                .frame(width:300, height: 75)
                                .foregroundColor(Color.primary)
                            }
                        }
                    
                    }
                    .padding([.top], 75)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom)).foregroundColor(Color.black)
                    
                    Button(action: {
                        
                        if validateForm(){
                            vm.addGoal(name: goalName, isHours: isHours, value: value, completedPoints: completedPoints, startDate: startDate, endDate: endDate, isComplete: false)
                            print("goal has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of goal")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Task").font(.body)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    })

                    .buttonStyle(PressableButtonStyle())
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    
                    
                    
                }.scrollContentBackground(.hidden)
                    .background(Color(red: 0.50, green: 0.70, blue: 1))
                
            }
            
        }
        .scrollContentBackground(.hidden)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom))
            .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)

    }
    
    func validateForm() -> Bool {
        
        let str = goalName
        let str2 = goalName
        let smallCharCount: Float = str.reduce(0) {
            $1 == "l" || $1 == "." || $1 == "," || $1 == " " || $1 == "i" || $1 == "t" || $1 == "f" || $1 == "j" || $1 == "'" ? $0 + 1 : $0 }
        let largeCharCount: Float = str2.reduce(0) {
            $1 == "w" || $1 == "m" || $1.isUppercase  ? $0 + 1 : $0 }
        
        let tally: Float = Float((goalName.count)*2) - (smallCharCount) + (largeCharCount)
        
        print("smallCharCount: \(smallCharCount) largeCharCount: \(largeCharCount)")
        
        print("\((goalName.count)*2) - \(smallCharCount) + \(largeCharCount)")
        
        if goalName.isEmpty || Int(tally) > 42 {
          return false
        }
        return true
      }
                
}

struct AddGoalView_Previews: PreviewProvider {
    struct AddGoalViewContainer: View {
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                AddGoalView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        AddGoalViewContainer()
    }
}


//
//  AddGoalView.swift
//  Demo2
//
//  Created by Coding on 2023-10-02.
//

import SwiftUI

struct AddGoalView: View {
    @ObservedObject var vm: CoreDataViewModel
    let date = Date()
    @Binding var sortSelection: Int
    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var goalName: String = "" //name of goal
    @State private var isHours: Bool = false        //hour based goal or task based goal
    @State private var value: Float = 0             // number of hours/tasks needed to complete goal
    @State private var startDate = Date()     //start date of goal
    @State private var endDate = Date().addingTimeInterval(86400)            //end date of goal
    @State private var completedPoints: Int = 0     //points awarded upon goal completion
    @State private var currentValue: Float = 0      //how many hours/tasks are currently completed
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("Goal Description"){
                            
                            VStack{
                                
                                if errorMsg == "Goal successfully added!"
                                {
                                    if changeColor
                                    {
                                        Text(errorMsg).foregroundColor(Color.green).font(.caption)
                                    }
                                    else
                                    {
                                        Text(errorMsg).foregroundColor(Color.blue).font(.caption)
                                    }
                                }
                                HStack{
                                    Text("Name of Goal")
                                        .font(.title2)
                                        .foregroundColor(Color.secondary)
                                    Spacer()
                                }
                                
                                if errorMsg == "* Too many characters!" || errorMsg == "* This field can't be empty!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                TextField("", text: $goalName)
                                    .frame(width:300)
                                    .font(.title3)
                                    .foregroundColor(Color.primary)
                            }
                            
                            Picker(selection: $isHours, label: Text("Measure").foregroundColor(Color.secondary).font(.title2))
                            {
                                Text("# of Tasks ").tag(false).foregroundColor(Color.primary).font(.title3)
                                Text("# of Hours").tag(true).foregroundColor(Color.primary).font(.title3)
                            }
                            
                            
                            VStack{
                            
                                if errorMsg == "* This field has to be greater than 0 and less than 100!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                            
                            //measure
                            HStack{
                                
                                if isHours {
                                    Text("# of Hours").foregroundColor(Color.secondary).font(.title2)
                                }
                                else
                                {
                                    Text("# of Tasks").foregroundColor(Color.secondary).font(.title2)
                                }
                                Spacer()
                                TextField("", value: $value, format: .number)
                                    .padding([.trailing], 20).frame(maxWidth: 100).foregroundColor(Color.primary).font(.title3)
                            }
                            .frame(height:40)
                            
                            
                            }
                            
                            VStack{
                                
                                if errorMsg == "* This field has cannot be less than 0 or more than 100,000"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                //points awarded
                                HStack{
                                    
                                    Text("Points awarded").foregroundColor(Color.secondary).font(.title2)
                                    Spacer()
                                   TextField("", value: $completedPoints, format: .number)
                                        .padding([.trailing], 20).frame(maxWidth: 100).foregroundColor(Color.primary).font(.title3)
                                }
                                .frame(height:40)
                            }
                            
                            VStack{
                                
                                if errorMsg == "* End date cannot be before or the same as the Start date!" || errorMsg == "* Start date cannot be from the past!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                HStack{
                                    
                                    VStack(alignment: .center){
                                        Text("       Start").font(.body).foregroundColor(Color.secondary)
                                        DatePicker("",
                                                   selection: $startDate,
                                                   displayedComponents: [.date]
                                        )
                                    }
                                    VStack(alignment: .center){
                                        Text("      End").font(.body).foregroundColor(Color.secondary)
                                        DatePicker("",
                                                   selection: $endDate,
                                                   displayedComponents: [.date]
                                        )
                                    }
                                }.frame(width:300)
                                    .foregroundColor(Color.primary)
                            }
                        }
                    
                    }
                    .padding([.top], 75)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom)
                        )
                    
                    Button(action: {
                        
                        if validateForm(){
                            
                            //reset sorting in goalview
                            sortSelection = 0
                            vm.addGoal(name: goalName, isHours: isHours, value: value, currentValue: 0, startDate: startDate, endDate: endDate, completedPoints: completedPoints, isComplete: false)
                            
                            
                            print("goal has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of goal")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Goal").font(.body)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    })

                    .buttonStyle(PressableButtonStyle())
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    
                    Spacer().frame(maxHeight: 30)
                    
                }.ignoresSafeArea(.keyboard, edges: .bottom)
                    .background(Color(light: Library.customBlue2, dark: Library.customGray2))
                
            }
            
        }
        .scrollContentBackground(.hidden)
        //moved graident from here
            .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)

    }
    
    func validateForm() -> Bool {
        

        let yesterday = Date.now.addingTimeInterval(-86400)
        
        let str = goalName
        let str2 = goalName
        let smallCharCount: Float = str.reduce(0) {
            $1 == "l" || $1 == "." || $1 == "," || $1 == " " || $1 == "i" || $1 == "t" || $1 == "f" || $1 == "j" || $1 == "'" ? $0 + 1 : $0 }
        let largeCharCount: Float = str2.reduce(0) {
            $1 == "w" || $1 == "m" || $1.isUppercase  ? $0 + 1 : $0 }
        
        let tally: Float = Float((goalName.count)*2) - (smallCharCount) + (largeCharCount)
        
        print("smallCharCount: \(smallCharCount) largeCharCount: \(largeCharCount)")
        
        print("\((goalName.count)*2) - \(smallCharCount) + \(largeCharCount)")
        
        if goalName.isEmpty
        {
            errorMsg = "* This field can't be empty!"
            return false
        }
        if Int(tally) > 42
        {
          errorMsg = "* Too many characters!"
          return false
        }
        if value <= 0 || value > 100
        {
            errorMsg = "* This field has to be greater than 0 and less than 100!"
            return false
        }
        if completedPoints < 0 || completedPoints >= 100000
        {
            errorMsg = "* This field has cannot be less than 0 or more than 100,000"
            return false
        }
        if startDate >= endDate
        {
            errorMsg = "* End date cannot be before or the same as the Start date!"
            return false
        }
        if startDate < yesterday
        {
            errorMsg = "* Start date cannot be from the past!"
            return false
        }
        changeColor.toggle()
        errorMsg = "Goal successfully added!"
        return true
      }
                
}

struct AddGoalView_Previews: PreviewProvider {
    struct AddGoalViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        
            var body: some View {
                AddGoalView(vm: self.vm, sortSelection: $sortSelection)
            }
        }
    
    static var previews: some View {
        AddGoalViewContainer()
    }
}


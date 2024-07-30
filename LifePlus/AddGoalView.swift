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
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    
    
    @State private var goalName: String = "" //name of goal
    @State private var goalSInfo: String = "" //specific info of goal
    @State private var goalRInfo: String = "" //relevant info of goal
    @State private var startDate = Date()     //start date of goal
    @State private var endDate = Date().addingTimeInterval(86400)            //end date of goal
    @State private var completedPoints: Int = 0     //points awarded upon goal completion

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
                            
                            VStack
                            {
                                HStack{
                                    Text("Specific Description")
                                        .font(.title2)
                                        .foregroundColor(Color.secondary)
                                    
                                    Button(action: {
                                        
                                        namePopUp = "Specific"
                                        infoPopUp = "In order for a goal to be effective, it needs to be specific. What needs to be accomplished? Who’s responsible for it? What steps need to be taken to achieve it?"
                                        showPopUp = true
                                    }, label: {
                                        
                                        Image(systemName: "info.circle")
                                            .font(.title3)
                                            .foregroundColor(Color.blue)
                                    })
                                    .buttonStyle(PressableButtonStyle())
                                    .frame(width:20, height: 35)
                                    .padding([.trailing], 5 /*vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: steplist)*/)
                                    
                                    Spacer()
                                }
                                
                                if errorMsg == "* Too many characters in description!" || errorMsg == "* Description can't be empty"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                
                            TextEditor(text: $goalSInfo)
                                    .frame(height: 135)
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .border(Color.secondary)
                                    
                            }
                            
                            VStack
                            {
                                HStack{
                                    Text("Relevant Description")
                                        .font(.title2)
                                        .foregroundColor(Color.secondary)
                                    
                                    Button(action: {
                                        
                                        namePopUp = "Relevant"
                                        infoPopUp = "Here’s where you need to think about the big picture. Why are you setting the goal that you’re setting?"
                                        showPopUp = true
                                    }, label: {
                                        
                                        Image(systemName: "info.circle")
                                            .font(.title3)
                                            .foregroundColor(Color.blue)
                                    })
                                    .buttonStyle(PressableButtonStyle())
                                    .frame(width:20, height: 35)
                                    .padding([.trailing], 5 /*vm.dynamicSpacing(task: task, inCalendar: inCalendar, tasklist: steplist)*/)
                                    
                                    Spacer()
                                }
                                
                                if errorMsg == "*Too many characters in description!" || errorMsg == "*Description can't be empty"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                
                            TextEditor(text: $goalRInfo)
                                    .frame(height: 135)
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .border(Color.secondary)
                                    
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
                                    
                                    VStack(/*alignment: .center*/){
                                        Text("       Start").font(.body).foregroundColor(Color.secondary)
                                        DatePicker("", selection: $startDate, displayedComponents: [.date])
                                    }
                                    VStack(/*alignment: .center*/){
                                        Text("      End").font(.body).foregroundColor(Color.secondary)
                                        DatePicker("", selection: $endDate, displayedComponents: [.date])
                                    }
                                }.frame(width:300)
                                //.foregroundColor(Color.primary)
                            }
                        }
                    
                    }
                    .padding([.top], 1) //this is necessary
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom)
                        )
                    
                    Button(action: {
                        
                        if validateForm(){
                            
                            //reset sorting in goalview
                            sortSelection = 0
                            vm.addGoal(name: goalName, infoS: goalSInfo, infoR: goalRInfo, startDate: startDate, endDate: endDate, completedPoints: completedPoints)
                            
    
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
            
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
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
        if goalSInfo.isEmpty
        {
            errorMsg = "* Description can't be empty"
            return false
        }
        if goalSInfo.count > 150
        {
            errorMsg = "* Too many characters in description!"
            return false
        }
        if goalRInfo.isEmpty
        {
            errorMsg = "*Description can't be empty"
            return false
        }
        if goalRInfo.count > 150
        {
            errorMsg = "*Too many characters in description!"
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


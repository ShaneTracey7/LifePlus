//
//  AddListView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-13.
//

import SwiftUI

struct AddListView: View {
    @ObservedObject var vm: CoreDataViewModel
    @Binding var sortSelection: Int
    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var listName: String = "" //name of list
    @State private var listStyle: String = ""
    @State private var startDate = Date()     //start date of list
    @State private var endDate = Date().addingTimeInterval(86400)            //end date of list

    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section("List Description"){
                            
                            VStack{
                                if errorMsg == "* Too many characters!" || errorMsg == "* This field can't be empty!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                if errorMsg == "List successfully added!"
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
                                
                                TextField("Name of List", text: $listName)
                                    .frame(width:300)
                                    .font(.title2)
                                    .cornerRadius(25)
                                    .padding([.top], 25)
                                    .foregroundColor(Color.primary)
                            }
                            
                            
                            Picker(selection: $listStyle, label: Text("Style").foregroundColor(Color.primary))
                            {
                                
                                Text("\("")").tag("")
                                let styles = ["basic", "task", "grocery"]
                                ForEach(styles, id: \.self) { style in
                                    Text("\(style)").tag(style)
                                }
                            }

                            VStack{
                                
                                if errorMsg == "* End date cannot be before or the same as the Start date!" || errorMsg == "* Start date cannot be from the past!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                HStack{
                                    
                                    VStack(alignment: .center){
                                        Text("       Start").font(.body)
                                        DatePicker("",
                                                   selection: $startDate,
                                                   displayedComponents: [.date]
                                        )
                                    }
                                    VStack(alignment: .center){
                                        Text("      End").font(.body)
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
                            vm.addList(name: listName, startDate: startDate, endDate: endDate, isComplete: false)
                            
                            
                            print("goal has been added")
                        }
                        else
                        {
                            print("Incorrect input for name of goal")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add List").font(.body)
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
        
        let str = listName
        let str2 = listName
        let smallCharCount: Float = str.reduce(0) {
            $1 == "l" || $1 == "." || $1 == "," || $1 == " " || $1 == "i" || $1 == "t" || $1 == "f" || $1 == "j" || $1 == "'" ? $0 + 1 : $0 }
        let largeCharCount: Float = str2.reduce(0) {
            $1 == "w" || $1 == "m" || $1.isUppercase  ? $0 + 1 : $0 }
        
        let tally: Float = Float((listName.count)*2) - (smallCharCount) + (largeCharCount)
        
        print("smallCharCount: \(smallCharCount) largeCharCount: \(largeCharCount)")
        
        print("\((listName.count)*2) - \(smallCharCount) + \(largeCharCount)")
        
        if listName.isEmpty
        {
            errorMsg = "* This field can't be empty!"
            return false
        }
        if Int(tally) > 42
        {
          errorMsg = "* Too many characters!"
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
        errorMsg = "List successfully added!"
        return true
      }
                
}

struct AddListView_Previews: PreviewProvider {
    struct AddListViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var sortSelection: Int = 0
        
            var body: some View {
                AddListView(vm: self.vm, sortSelection: $sortSelection)
            }
        }
    
    static var previews: some View {
        AddListViewContainer()
    }
}

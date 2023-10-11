//
//  AddRewardView.swift
//  LifePlus
//
//  Created by Coding on 2023-10-11.
//

import SwiftUI

struct AddRewardView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @State var errorMsg: String = ""
    @State var changeColor: Bool = false
    
    @State private var rewardName: String = ""
   @State private var rewardImage: String = "" //the reward icon
    @State private var rewardPrice: Int = 0 // 2000, 4000, 8000, or 16000
    let prices = [2000,4000,8000,16000]
    
    
    
    var body: some View {
        
        ZStack{
            
            Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            
            NavigationStack{
                
                VStack{
                    
                    Form{

                        Section(Reward Details"){
                            
                            VStack{
                                
                                if errorMsg == "Reward successfully added!"
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
                                    Text("Name of Reward")
                                        .font(.title2)
                                        .foregroundColor(Color.secondary)
                                    Spacer()
                                }
                                
                                
                                if errorMsg == "* Too many characters!" || errorMsg == "* This field can't be empty!"
                                {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                    TextField("", text: $rewardName)
                                        .font(.title3)
                                        .foregroundColor(Color.primary)
                            }
                            
                            VStack{
                                
                                if errorMsg == "* Price must be at least 2000 points!"
                                    {
                                    Text(errorMsg).foregroundColor(Color.red).font(.caption)
                                }
                                
                                Picker(selection: $rewardPrice, label: Text("Price"))
                                {
                                    Text("\(0)").tag(0)
                                    ForEach(prices, id: \.self) { price in
                                        Text("\(price)").tag(min)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                            }
                            
                            
                        }
                        .frame(width: 300)
                        
                        
                    }
                    .scrollDisabled(true)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom))
                    
                    Button(action: {
                        
                        if validateForm(){
                            
                            vm.addReward(name: rewardName, price: Int32(price), image: rewardImage, isPurchased: false, isUsed: false))
                            
                            //add to currentValue of Goals
                            
                            print("reward has been added")
                        }
                        else
                        {
                            print("Incorrect input for reward")
                        }
                        
                        
                    }, label: {
                        VStack{
                            
                            Image(systemName: "plus.app").font(.title)
                            Text("Add Reward").font(.body)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .buttonStyle(PressableButtonStyle())
                    .frame(width:150, height: 75)
                    .background(Color.green)
                    .cornerRadius(25)
                    .foregroundColor(Color.white)
                    
                    //Spacer().frame(maxHeight: 40)
                
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                    .background(Color(light: Library.customBlue2, dark: Library.customGray2))
            }
            
        }
        .scrollContentBackground(.hidden)
        //moved graident from here
            
            .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)

    }
    
    func validateForm() -> Bool {
        
       
        
        let str = rewardName
        let str2 = rewardName
        let smallCharCount: Float = str.reduce(0) {
            $1 == "l" || $1 == "." || $1 == "," || $1 == " " || $1 == "i" || $1 == "t" || $1 == "f" || $1 == "j" || $1 == "'" ? $0 + 1 : $0 }
        let largeCharCount: Float = str2.reduce(0) {
            $1 == "w" || $1 == "m" || $1.isUppercase  ? $0 + 1 : $0 }
        
        let tally: Float = Float((rewardName.count)*2) - (smallCharCount) + (largeCharCount)
        
        print("smallCharCount: \(smallCharCount) largeCharCount: \(largeCharCount)")
        
        print("\((rewardName.count)*2) - \(smallCharCount) + \(largeCharCount)")
        
        if rewardName.isEmpty
        {
            errorMsg = "* This field can't be empty!"
            return false
        }
        else if Int(tally) > 42
        {
          errorMsg = "* Too many characters!"
          return false
        }
        
        else if rewardPrice == 0
        {
            errorMsg = "* Price must be at least 2000 points!"
            return false
        }
        
        changeColor.toggle()
        errorMsg = "Reward successfully added!"
        return true
      }
                
}

struct AddRewardView_Previews: PreviewProvider {
    struct AddTaskViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                AddRewardView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        AddRewardViewContainer()
    }
}


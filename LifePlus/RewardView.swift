//
//  RewardView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct RewardView: View {
    
    @ObservedObject var vm:CoreDataViewModel
    @State var showPopUp: Bool = false
    @State var editOn: Bool = false
    @State var rewardLevel: Int32  = 2000
    var body: some View {


        
            ZStack{
                
                VStack(spacing: 15){
                    
                    
                    HStack{
                        Text("Rewards").font(.title).foregroundColor(Color.white).frame(height: 50).padding([.leading], 135)
                        
                        Spacer()
                        
                        VStack(spacing: 0){
                            Text("Edit").font(.body).foregroundColor(Color.white).multilineTextAlignment(.center)
                            Toggle("",isOn: $editOn ).toggleStyle(.switch).padding([.trailing],15).padding([.bottom],5)
                        }.frame(width: 75)
                            //.border(Color.red)
                            .background(Color.blue)
                            .cornerRadius(15)
                        
                    }.padding([.trailing], 10)
                        //reward points gauge
                        VStack (spacing: 0){
                            
                            Text("\(vm.pointEntities[1].value) points").padding([.leading], 200)
                                .font(.caption)
                                .foregroundColor(Color.green)
                            
                            HStack{
                                
                                Image(systemName: "bolt.circle").font(.title).foregroundColor(Color.green)
                                
                                HStack{
                                    Gauge(value: Float(Library.gaugeSet(points: Int(vm.pointEntities[1].value))[0]), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    
                                    Gauge(value: Float(Library.gaugeSet(points: Int(vm.pointEntities[1].value))[1]), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(Library.gaugeSet(points: Int(vm.pointEntities[1].value))[2]), in: 0...4000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(Library.gaugeSet(points: Int(vm.pointEntities[1].value))[3]), in: 0...8000){}.tint(Gradient(colors: [.blue, .green]))
                                }
                                
                            }.padding([.leading, .trailing], 20)
                            
                            
                            Button(action: {
                                
                                showPopUp = true
                            }, label: {

                                    Image(systemName: "info.circle").foregroundColor(Color.blue)
                            })
                            .buttonStyle(PressableButtonStyle())
                            .padding([.leading], 250)
                            
                            
                            
                        }.frame(width: 300, height: 75)
                        .background(Color.primary.colorInvert())
                            .cornerRadius(15)
                            .shadow(radius: 10, x: 5, y: 5)
                    
                    
                    
                    ScrollView{
                        
                        VStack{
                            
                            NavigationStack{
                                
                                if editOn
                                {
                                    NavigationLink(destination: AddRewardView(vm: self.vm)){
                                        Image(systemName: "plus")
                                    }
                                }
                            }
                            
                            Text("2000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                                .foregroundColor(Color.blue)
                                .font(.title3)
                            Divider()
                            //static
                            
                            ForEach(vm.rewardEntities1) { reward in
                                RewardCView(vm: vm, editOn: $editOn, reward: reward)
                            }
                            if vm.rewardEntities1.isEmpty
                            {
                                Spacer().frame(height: 90)
                            }
                        }
                        VStack{
                            Text("4000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                                .foregroundColor(Color.blue)
                                .font(.title3)
                            Divider()
                            //static
                            ForEach(vm.rewardEntities2) { reward in
                                RewardCView(vm: vm, editOn: $editOn, reward: reward)
                            }
                            if vm.rewardEntities2.isEmpty
                            {
                                Spacer().frame(height: 90)
                            }
                        }
                        VStack{
                            Text("8000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                                .foregroundColor(Color.blue)
                                .font(.title3)
                            Divider()
                            //static
                            ForEach(vm.rewardEntities3) { reward in
                                RewardCView(vm: vm, editOn: $editOn, reward: reward)
                            }
                            if vm.rewardEntities3.isEmpty
                            {
                                Spacer().frame(height: 90)
                            }
                        }
                        
                        VStack{
                            
                            Text("16000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                                .foregroundColor(Color.blue)
                                .font(.title3)
                            Divider()
                            //static
                            ForEach(vm.rewardEntities4) { reward in
                                RewardCView(vm: vm, editOn: $editOn, reward: reward)
                            }
                            Spacer(minLength: 100)
                        }
                        
                    }
                    
                }.padding([.top], 50)
 
                PopUpWindow(title: "Info", message: "The progress bar is segmented to represent the reward levels. For every task you complete, you gain 100 and 400 additional points for every hour the task took.", buttonText: "Ok", show: $showPopUp)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom)
                )
        
            
    }
}

struct RewardView_Previews: PreviewProvider {
    struct RewardViewContainer: View {
        @State var vm = CoreDataViewModel()
        

            var body: some View {
                RewardView(vm: self.vm)
            }
        }
    static var previews: some View {
        RewardViewContainer()
    }
}

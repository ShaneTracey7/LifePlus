//
//  RewardCView.swift
//  Demo2
//
//  Created by Coding on 2023-09-21.
//

import SwiftUI

struct RewardCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @Binding var editOn: Bool
    @State var doubleCheck: Bool = false
    @State var reward: RewardEntity
    var body: some View {
        
        HStack(spacing:20){
            
            //reward button (subtracts reward points, adds reward to walletView
            Button {
                
                if Int(vm.pointEntities[1].value) >= reward.price
                {
                    //takes away points for purchasing reward
                    vm.addPoints(entity: vm.pointEntities[1], increment: Int((reward.price)*(-1)))
    
                    //add reward to wallet
                    vm.addToWallet(name: reward.name ?? "" , price: reward.price, image: reward.image ?? "", isPurchased: true, isUsed: reward.isUsed)

                }
                
                else
                {
                    //do nothing
                    print("not enough points")
                }
                    
                print("reward button was pressed")
                    
            } label: {
                Image(systemName: reward.image ?? "") //image of reward
                    .font(.title).foregroundColor(Color.green)
            }.frame(width: 50, height: 50).background(Color.primary.colorInvert()).cornerRadius(15).buttonStyle(.plain)
                
                
            Text(reward.name ?? "").foregroundColor(Color.white)//name of reward
            
            if editOn
            {
                Spacer()
                
                //delete reward button
                Button(role: .destructive,
                       action: {
                    withAnimation{
                        
                        print("delete reward button was pressed")
                        doubleCheck = true
                    }
                    
                },
                       label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color.red)
                        .font(.title)
                })
                .frame(width: 50, height: 50).buttonStyle(.plain).padding([.trailing], 10)
                .confirmationDialog(
                    "Are you sure?",
                    isPresented: $doubleCheck,
                    titleVisibility: .visible
                )
                {
                    Button("Yes", role: .destructive)
                    {
                        switch(Int(reward.price))
                        {
                        case 2000:
                            let index = vm.rewardEntities1.firstIndex(of: reward)
                            vm.deleteReward(index: index ?? 0, arr: vm.rewardEntities1)
                            
                        case 4000:
                            let index = vm.rewardEntities2.firstIndex(of: reward)
                            vm.deleteReward(index: index ?? 0, arr: vm.rewardEntities2)
                            
                        case 8000:
                            let index = vm.rewardEntities3.firstIndex(of: reward)
                            vm.deleteReward(index: index ?? 0, arr: vm.rewardEntities3)
                            
                        case 16000:
                            let index = vm.rewardEntities4.firstIndex(of: reward)
                            vm.deleteReward(index: index ?? 0, arr: vm.rewardEntities4)
                            
                        default: print("reward doesn't have the correct price")
                        }
                        //might have to also delete form masterRewardEntities
                        
                        print("confirmation delete button was pressed")
                    }
                    Button("No", role: .cancel){}
                }
            }
            
            if reward.isPurchased && reward.isUsed
            {
                Text("Redeemed").font(.caption).foregroundColor(.red)
            }
            else if(reward.isPurchased)
            {
                VStack{
                    Text("Purchased").font(.caption).foregroundColor(.green)
                    //button to
                    Button {
                        vm.setUsed(entity: reward)
                    } label: {
                        Text("Redeem").foregroundColor(Color.red).font(.caption)
                    }.frame(width: 75, height: 20).background(Color.primary.colorInvert()).cornerRadius(15).buttonStyle(.plain)
                }.frame(alignment: .trailing)
            }
            else
            {
                //do nothing
            }
            
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 75)
            .padding([.leading], 50)
            
    }
}

struct RewardCView_Previews: PreviewProvider {
    struct RewardCViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var reward = RewardEntity()
        @State var editOn: Bool = false
            var body: some View {
                RewardCView(vm: self.vm, editOn: self.$editOn, reward: self.reward)
            }
        }
    
    static var previews: some View {
        RewardCViewContainer()
    }
}

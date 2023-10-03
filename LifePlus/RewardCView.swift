//
//  RewardCView.swift
//  Demo2
//
//  Created by Coding on 2023-09-21.
//

import SwiftUI

struct RewardCView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
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
                    vm.addReward(name: reward.name ?? "" , price: reward.price, image: reward.image ?? "", isPurchased: true, isUsed: reward.isUsed)

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
            var body: some View {
                RewardCView(vm: self.vm, reward: self.reward)
            }
        }
    
    static var previews: some View {
        RewardCViewContainer()
    }
}

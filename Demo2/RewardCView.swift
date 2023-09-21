//
//  RewardCView.swift
//  Demo2
//
//  Created by Coding on 2023-09-21.
//

import SwiftUI

struct RewardCView: View {
    @State var reward: Reward
    @Binding var rewardPoints: Int
    @Binding var purchasedRewards: [Reward]
    var body: some View {
        
        HStack(spacing:20){
            
            //reward button (subtracts reward points, adds reward to walletView
            Button {
                
                if rewardPoints >= reward.price
                {
                    rewardPoints -= reward.price //takes away points for purchasing reward
                    //add reward to wallet
                    let r: Reward = Reward(name: reward.name, image: reward.image, price: reward.price, isPurchased: reward.isPurchased, isUsed: reward.isUsed)
                    purchasedRewards.append(r)
                    
                    if let index = purchasedRewards.firstIndex (of: r)
                    {
                        purchasedRewards[index].isPurchased = true
                    }
                    
                    
 
                }
                
                else
                {
                    //do nothing
                    print("not enough points")
                }
                    
                print("reward button was pressed")
                    
            } label: {
                Image(systemName: reward.image) //image of reward
                    .font(.title).foregroundColor(Color.green)
            }.frame(width: 50, height: 50).background(Color.white).cornerRadius(15).buttonStyle(.plain)
                
                
            Text(reward.name)//name of reward
            
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
                        if let index = purchasedRewards.firstIndex (of: reward)
                        {
                            purchasedRewards[index].isUsed = true
                            reward.isUsed = true
                        }
                    } label: {
                        Text("Redeem").foregroundColor(Color.red).font(.caption)
                    }.frame(width: 75, height: 20).background(Color.white).cornerRadius(15).buttonStyle(.plain)
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
        @State var reward: Reward = Reward(name: "Get a Tasty Drink", image: "cup.and.saucer", price: 2000, isPurchased: false, isUsed: false)
        @State var rewardPoints: Int = 0
        @State var purchasedRewards: [Reward] = []
            var body: some View {
                RewardCView(reward: reward, rewardPoints: $rewardPoints, purchasedRewards: $purchasedRewards)
            }
        }
    
    static var previews: some View {
        RewardCViewContainer()
    }
}

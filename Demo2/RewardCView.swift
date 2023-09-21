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
    var body: some View {
        
        HStack(spacing:20){
            
            //reward button (subtracts reward points, adds reward to walletView
            Button {
                
                if rewardPoints >= reward.price
                {
                    rewardPoints -= reward.price //takes away points for purchasing reward
                    //add reward to wallet
                        
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
                
                
            Text(reward.name)                    //name of reward
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 75)
            .padding([.leading], 50)
            
    }
}

struct RewardCView_Previews: PreviewProvider {
    struct RewardCViewContainer: View {
        @State var reward: Reward = Reward(name: "Get a Tasty Drink", image: "cup.and.saucer", price: 2000, isPurchased: false, isUsed: false)
        @State var rewardPoints: Int = 100
            var body: some View {
                RewardCView(reward: reward, rewardPoints: $rewardPoints)
            }
        }
    
    static var previews: some View {
        RewardCViewContainer()
    }
}

//
//  WalletView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct WalletView: View {
    @Binding var purchasedRewards: [Reward]
    @Binding var rewardPoints: Int
    var body: some View {
        
        VStack{
            
            Text("Purchased Rewards").font(.title)
            
            ScrollView{
               
                ForEach(purchasedRewards) { reward in
                    
                    Divider()
                    RewardCView(reward: reward, rewardPoints: $rewardPoints, purchasedRewards: $purchasedRewards)
                
                }
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    struct WalletViewContainer: View {
        @State var purchasedRewards = [ Reward(name: "Get a Tasty Drink", image: "cup.and.saucer", price: 2000, isPurchased: false, isUsed: false), Reward(name: "Get a Tasty Treat", image: "birthday.cake", price: 2000, isPurchased: false, isUsed: false)]
        @State var rewardPoints: Int = 100
            var body: some View {
               WalletView(purchasedRewards: $purchasedRewards, rewardPoints: $rewardPoints)
            }
        }
    
    static var previews: some View {
        WalletViewContainer()
    }
}


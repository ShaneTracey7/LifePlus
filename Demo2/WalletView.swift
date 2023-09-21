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
    
        ZStack{
            
            
            VStack{
                
                Text("Wallet").font(.title)
                Divider()
                
                ScrollView{
                    
                    ForEach(purchasedRewards) { reward in
                        
                        RewardCView(reward: reward, rewardPoints: $rewardPoints, purchasedRewards: $purchasedRewards)
                        Divider()
                        
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom))
    }
}

struct WalletView_Previews: PreviewProvider {
    struct WalletViewContainer: View {
        @State var purchasedRewards: [Reward] = [] 
        @State var rewardPoints: Int = 0
            var body: some View {
               WalletView(purchasedRewards: $purchasedRewards, rewardPoints: $rewardPoints)
            }
        }
    
    static var previews: some View {
        WalletViewContainer()
    }
}


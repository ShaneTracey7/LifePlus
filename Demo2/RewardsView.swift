//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    @Binding var rewardPoints: Int
    @Binding var purchasedRewards: [Reward]
    var body: some View {
        
        TabView {
            RewardView(rewardPoints: self.$rewardPoints, purchasedRewards: self.$purchasedRewards)
                .tabItem {
                    Label("Rewards", systemImage: "trophy")
                }
            WalletView(purchasedRewards: self.$purchasedRewards,rewardPoints: self.$rewardPoints)
                .tabItem {
                    Label("Wallet", systemImage: "creditcard")
                }
        }
        
    }
}

struct RewardsView_Previews: PreviewProvider {
    struct RewardsViewContainer: View {
        @State var rewardPoints: Int = 0
        @State var purchasedRewards: [Reward] = []

            var body: some View {
                RewardView(rewardPoints: self.$rewardPoints, purchasedRewards: self.$purchasedRewards)
            }
        }
    static var previews: some View {
        RewardsViewContainer()
    }
}

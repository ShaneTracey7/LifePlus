//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    @Binding var rewardPoints: Int
    var body: some View {
        
        TabView {
            RewardView(rewardPoints: self.$rewardPoints)
                .tabItem {
                    Label("Rewards", systemImage: "trophy")
                }
            WalletView()
                .tabItem {
                    Label("Wallet", systemImage: "creditcard")
                }
        }
        
    }
}

struct RewardsView_Previews: PreviewProvider {
    struct RewardsViewContainer: View {
        @State var rewardPoints: Int = 100

            var body: some View {
                RewardView(rewardPoints: self.$rewardPoints)
            }
        }
    static var previews: some View {
        RewardsViewContainer()
    }
}

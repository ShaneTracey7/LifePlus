//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    @Binding var purchasedRewards: [Reward]
    var body: some View {
        
        TabView {
            RewardView(vm: vm, purchasedRewards: self.$purchasedRewards)
                .tabItem {
                    Label("Rewards", systemImage: "trophy")
                }
            WalletView(vm: vm, purchasedRewards: self.$purchasedRewards)
                .tabItem {
                    Label("Wallet", systemImage: "creditcard")
                }
        }
        
    }
}

struct RewardsView_Previews: PreviewProvider {
    struct RewardsViewContainer: View {
        @State var vm = CoreDataViewModel()
        @State var purchasedRewards: [Reward] = []
        

            var body: some View {
                RewardView(vm: self.vm, purchasedRewards: self.$purchasedRewards)
            }
        }
    static var previews: some View {
        RewardsViewContainer()
    }
}

//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    var body: some View {
        
        TabView {
            RewardView()
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
    static var previews: some View {
        RewardsView()
    }
}

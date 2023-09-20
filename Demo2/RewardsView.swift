//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    @State var points: Int
    var body: some View {
        
        TabView {
            RewardView(points: self.$points)
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
        @State var points: Int = 300

            var body: some View {
                RewardView(points: self.$points)
            }
        }
    static var previews: some View {
        RewardsViewContainer()
    }
}

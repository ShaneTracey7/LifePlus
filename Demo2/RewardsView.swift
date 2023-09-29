//
//  RewardsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct RewardsView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
        TabView {
            RewardView(vm: vm)
                .tabItem {
                    Label("Rewards", systemImage: "trophy")
                }
            WalletView(vm: vm)
                .tabItem {
                    Label("Wallet", systemImage: "creditcard")
                }
        }.environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        
    }
}

struct RewardsView_Previews: PreviewProvider {
    struct RewardsViewContainer: View {
        @State var vm = CoreDataViewModel()
        

            var body: some View {
                RewardView(vm: self.vm)
            }
        }
    static var previews: some View {
        RewardsViewContainer()
    }
}

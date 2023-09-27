//
//  WalletView.swift
//  Demo2
//
//  Created by Coding on 2023-09-19.
//

import SwiftUI

struct WalletView: View {
    
    @ObservedObject var vm:CoreDataViewModel

    var body: some View {
    
        ZStack{
            
            
            VStack{
                
                Text("Wallet").font(.title)
                Divider()
                
                ScrollView{
                    
                    ForEach(vm.rewardEntities) { reward in
                        
                        RewardCView(vm: vm, reward: reward)
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
        @ObservedObject var vm = CoreDataViewModel()
            var body: some View {
                WalletView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        WalletViewContainer()
    }
}


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
                
                Text("Wallet").font(.title).foregroundColor(Color.white)
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
                LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom)
                )
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


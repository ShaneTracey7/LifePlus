//
//  RewardView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct RewardView: View {
    @Binding var rewardPoints: Int
    var body: some View {

            ZStack{
                
                VStack{

                    //reward points gauge
                    VStack (spacing: 0){
                        
                        Text("\(rewardPoints) points").padding([.leading], 200)
                            .font(.caption)
                            .foregroundColor(Color.green)
                        
                        HStack{
                            
                            Image(systemName: "bolt.circle").font(.title).foregroundColor(Color.green)
                                
                                HStack{
                                    Gauge(value: Float(Reward.gaugeSet(points: rewardPoints)[0]), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    
                                    Gauge(value: Float(Reward.gaugeSet(points: rewardPoints)[1]), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(Reward.gaugeSet(points: rewardPoints)[2]), in: 0...4000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(Reward.gaugeSet(points: rewardPoints)[3]), in: 0...8000){}.tint(Gradient(colors: [.blue, .green]))
                                }
                                
                        }.padding([.leading, .trailing], 20)
                        
                        
                        Image(systemName: "info.circle")
                            .padding([.leading], 250).foregroundColor(Color.blue)
                    }.frame(width: 300, height: 75)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10, x: 5, y: 5)
                    
                    ScrollView{

                        Text("2000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                            .foregroundColor(Color.blue)
                            .font(.title3)
                        Divider()
                        VStack{
                            
                            //static
                            RewardCView(reward: Reward.initialData[0], rewardPoints: $rewardPoints)
                            RewardCView(reward: Reward.initialData[1], rewardPoints: $rewardPoints)
                        
                        }
                        Text("4000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                            .foregroundColor(Color.blue)
                            .font(.title3)
                        Divider()
                        VStack{
                            //static
                            RewardCView(reward: Reward.initialData[2], rewardPoints: $rewardPoints)
                            RewardCView(reward: Reward.initialData[3], rewardPoints: $rewardPoints)
                            RewardCView(reward: Reward.initialData[4], rewardPoints: $rewardPoints)
                            
                        }
                        
                        Text("8000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                            .foregroundColor(Color.blue)
                            .font(.title3)
                        Divider()
                        VStack{
                            //static
                            RewardCView(reward: Reward.initialData[5], rewardPoints: $rewardPoints)
                            RewardCView(reward: Reward.initialData[6], rewardPoints: $rewardPoints)
                        }
                        
                    }.padding([.top], 20)
                    
                }
 
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom))
    }
}

struct RewardView_Previews: PreviewProvider {
    struct RewardViewContainer: View {
        @State var rewardPoints: Int = 100

            var body: some View {
                RewardView(rewardPoints: self.$rewardPoints)
            }
        }
    static var previews: some View {
        RewardViewContainer()
    }
}

//
//  RewardView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct RewardView: View {
    @Binding var points: Int
    var body: some View {

            
            ZStack{
                
                VStack{
                    
                    
                    //reward points gauge
                    VStack (spacing: 0){
                        
                        Text("\(points) points").padding([.leading], 200)
                            .font(.caption)
                            .foregroundColor(Color.green)
                        
                        HStack{
                            
                            Image(systemName: "bolt.circle").font(.title).foregroundColor(Color.green)
                                
                                HStack{
                                    Gauge(value: Float(points), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    
                                    Gauge(value: Float(points - 2000), in: 0...2000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(points - 4000), in: 0...4000){}.tint(Gradient(colors: [.blue, .green]))
                                    Gauge(value: Float(points) - 8000, in: 0...8000){}.tint(Gradient(colors: [.blue, .green]))
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
                            HStack(spacing:20){
                                Image(systemName: "cup.and.saucer") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Get a tasty drink")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                            HStack(spacing:20){
                                Image(systemName: "birthday.cake") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Get a tasty treat")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                        }
                        Text("4000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                            .foregroundColor(Color.blue)
                            .font(.title3)
                        Divider()
                        VStack{
                            HStack(spacing:20){
                                Image(systemName: "takeoutbag.and.cup.and.straw") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Get some fast food")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                            HStack(spacing:20){
                                Image(systemName: "gamecontroller") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Play 1 hour of video games")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                            HStack(spacing:20){
                                Image(systemName: "bed.double") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Sleep-in an extra hour")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                        }
                        
                        Text("8000 points").frame(maxWidth: .infinity, alignment: .trailing).padding([.trailing], 20)
                            .foregroundColor(Color.blue)
                            .font(.title3)
                        Divider()
                        VStack{
                            HStack(spacing:20){
                                Image(systemName: "fork.knife") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Eat out / Get takeout")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                            HStack(spacing:20){
                                Image(systemName: "popcorn") //image of reward
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(Color.green)
                                Text("Go see a movie in theatres")                    //name of reward
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 75)
                                .padding([.leading], 50)
                            
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
        @State var points: Int = 100

            var body: some View {
                RewardView(points: self.$points)
            }
        }
    static var previews: some View {
        RewardViewContainer()
    }
}

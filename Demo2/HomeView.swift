//
//  HomeView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct HomeView: View {
    @State var points = 100
    @State var tasks = [
        Task(name: "Mow the Lawn",
             duration: 60,
             due : Date(),isComplete: false),
        Task(name: "Take out garbage",
             duration: 150,
             due : Date(),isComplete: false),
        Task(name: "Walk the dog",
             duration: 20,
             due : Date(),isComplete: false)
    ]
    var body: some View {
        
        NavigationStack {
            ZStack{
            
                VStack{
                
                    HStack(alignment: .bottom){
                        
                        //placeholder for lifeplus logo
                        Text("LifePlus").padding(.leading, 130)
                            .padding(.trailing, 80)
                            .padding(.top,50)
                            .font(.title)
                            .foregroundColor(Color.blue)
                    
                        NavigationLink(destination: HelpView()){
                        
                                Image(systemName: "gearshape")
                                    .foregroundColor(Color.blue)
                                    .font(.title)
                        
                        }
                    
                    }
                    .frame(width: 450, height: 100)
                    .background(Color.white)
                    .ignoresSafeArea()
                    
                    
                    //lvl the user has
                    VStack (spacing: 0){
                        
                        Text("\(points) / 600 points").padding([.leading], 175)
                            .font(.caption)
                            .foregroundColor(Color.green)
                        
                        HStack{
                            
                            Image(systemName: "bolt.circle").font(.title).foregroundColor(Color.green)
                                
                              
                                    Gauge(value: Float(points), in: 0...5000){}.tint(Gradient(colors: [.blue, .green]))
                                    
                                
                        }.padding([.leading, .trailing], 20)
                        
                        
                        Text("Lvl. 5")
                            .padding([.leading], 230).foregroundColor(Color.blue)
                    }.frame(width: 300, height: 75)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10, x: 5, y: 5)
                        .padding(.bottom, 30)
                    
                    // percent task complete gauge
                    Gauge(value: Float(points), in: 0...5000){}.tint(Gradient(colors: [.blue, .green])).gaugeStyle(.accessoryCircular)  //placeholder for task complete % the person has
                        .frame(width:175, height: 175)
                        
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.bottom, 30)
                
                    VStack(spacing: 20){
                    
                        HStack(spacing: 20){
                            NavigationLink(destination: TaskListView(points: self.$points, tasks: self.$tasks)){
                                VStack{
                                Text("Lists")
                                Image(systemName: "list.clipboard")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.green)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                        
                        
                            NavigationLink(destination: RewardsView(points: self.points)){
                                VStack{
                                    Text("Rewards")
                                    Image(systemName: "trophy.circle")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.red)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                        }
                        HStack(spacing:20){
                        
                            NavigationLink(destination: GoalView())
                            {
                                VStack{
                                    Text("Goals")
                                    Image(systemName: "scope")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                        
                        
                            NavigationLink(destination: ScoreView())
                            {
                                VStack{
                                Text("Score")
                                Image(systemName: "gauge.high")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                            
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.orange)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom)
                )
        
           
        }
        
        
    }
        
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

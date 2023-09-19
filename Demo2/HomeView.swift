//
//  HomeView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct HomeView: View {
    @State var tasks = [
        Task(name: "Mow the Lawn",
             duration: 60,
             due : Date()),
        Task(name: "Take out garbage",
             duration: 150,
             due : Date()),
        Task(name: "Walk the dog",
             duration: 20,
             due : Date())
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
                    
                
                    Rectangle()  //placeholder for current lvl the person is
                        .frame(width:300, height: 100)
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 30)
                    
                
                    Rectangle()  //placeholder for task complete % the person has
                        .frame(width:175, height: 175)
                        .cornerRadius(15)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 30)
                
                    VStack(spacing: 20){
                    
                        HStack(spacing: 20){
                            NavigationLink(destination: TaskListView(tasks: self.$tasks)){
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
                        
                        
                            NavigationLink(destination: RewardsView()){
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
        
           /* .toolbar {
                Text("LifePlus").padding(.leading, 110)
                    .padding(.trailing, 80)
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .background(Color.white)
            
                NavigationLink(destination: HelpView()){
                
                        Image(systemName: "gearshape")
                            .foregroundColor(Color.blue)
                            .font(.title3)
                            
                
                }
                .background(Color.white)
                
            } */
        }
        
        
    }
        
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

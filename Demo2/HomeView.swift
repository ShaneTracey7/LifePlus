//
//  HomeView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @StateObject var lightSettings = LightSettings()
    
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
                    
                        NavigationLink(destination: HelpView(vm: vm)){
                        
                                Image(systemName: "gearshape")
                                    .foregroundColor(Color.blue)
                                    .font(.title)
                                    
                        
                        }.buttonStyle(.plain)
                    
                    }
                    .frame(width: 450, height: 100)
                    .background(Color.white)
                    .ignoresSafeArea()
                    
                    
                    //lvl the user has
                    VStack (spacing: 0){
                        
                        
                        Text("\(Library.updateLvl(points: Int(vm.pointEntities[0].value))[0]) / \(Library.updateLvl(points: Int(vm.pointEntities[0].value))[1])") .padding([.leading], 175)
                            .font(.caption)
                            .foregroundColor(Color.green)
                        
                        HStack{
                            
                            Image(systemName: "bolt.circle").font(.title).foregroundColor(Color.green)
                                
                              
                            Gauge(value: Float((Library.updateLvl(points: Int(vm.pointEntities[0].value))[0]))/Float((Library.updateLvl(points: Int(vm.pointEntities[0].value))[1])), in: 0...1){}.tint(Gradient(colors: [.blue, .green]))
                                    
                                
                        }.padding([.leading, .trailing], 20)
                        
                        
                        Text("Lvl. \(Library.updateLvl(points: Int(vm.pointEntities[0].value))[2])")
                            .padding([.leading], 230).foregroundColor(Color.blue)
                    }.frame(width: 300, height: 75)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10, x: 5, y: 5)
                        .padding(.bottom, 30)
                    
                    // percent task complete gauge
                    VStack{
                        Gauge(value: (Library.getPercent(t: vm.taskEntities)), in: 0...1){
                        } currentValueLabel: {
                            HStack(spacing: 0){
                                Text("\(Int(Library.getPercent(t: vm.taskEntities) * 100))")
                                    .font(.body)
                                Image(systemName: "percent").font(.caption2)
                            }.foregroundColor(Color.black)
                        }
                        .tint(Gradient(colors: [.blue, .green])).gaugeStyle(.accessoryCircular)
                        .scaleEffect(2)
                        .background(Color.white)
                        .padding([.top], 20)
                        
                        Text("Tasks Completed").padding([.top], 20).foregroundColor(Color.black)
                        
                    }.frame(width:175, height: 175)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10, x: -5, y: 5)
                
                    VStack(spacing: 20){
                    
                        HStack(spacing: 20){
                            NavigationLink(destination: TaskListView(vm: vm)){
                                VStack{
                                Text("Lists")
                                Image(systemName: "list.clipboard")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.green)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        
                        
                            NavigationLink(destination: RewardsView(vm: vm)){
                                VStack{
                                    Text("Rewards")
                                    Image(systemName: "trophy.circle")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.red)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
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
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        
                            NavigationLink(destination: ScoreView())
                            {
                                VStack{
                                Text("Score")
                                Image(systemName: "gauge.high")
                                }
                                .foregroundColor(Color.white)
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.orange)
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        }
                    }.padding([.top], 30)
                    
                    Spacer(minLength: 50)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.90, blue: 1),Color(red: 0.50, green: 0.70, blue: 1)]), startPoint: .top, endPoint: .bottom)
                )
        
           
        }.environmentObject(lightSettings)
        
        
    }
        
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LightSettings())
    }
}

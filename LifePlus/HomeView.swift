//
//  HomeView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    
    var body: some View {
        
        NavigationStack {
            ZStack{
            
                VStack{
                
                    HStack(alignment: .bottom){
                        
                        //placeholder for lifeplus logo
                        if vm.modeEntities[0].isDark
                        {
                            Image("logo_darkMode").resizable()
                                .frame(width: 150, height: 80)
                                //.border(Color.blue)
                                .padding(.leading, 170)
                                .padding(.top, 30)
                        }
                        else
                        {
                            Image("logo").resizable()
                                .frame(width: 150, height: 80)
                                //.border(Color.blue)
                                .padding(.leading, 170)
                                .padding(.top, 30)
                        }
                        

                        Spacer()
                        
                        NavigationLink(destination: HelpView(vm: vm)){
                        
                                Image(systemName: "gearshape")
                                    .foregroundColor(Color.blue)
                                    .font(.title)
                                    
                        }.buttonStyle(.plain).padding(.trailing, 40).padding(.bottom, 25)
                    
                    }
                    .frame(width: 450, height: 115)
                    .background(Color.primary.colorInvert())
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
                        .background(Color.primary.colorInvert())
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
                            }.foregroundColor(Color.primary)
                        }
                        .tint(Gradient(colors: [.blue, .green])).gaugeStyle(.accessoryCircular)
                        .scaleEffect(2)
                        .background(Color.primary.colorInvert())
                        .padding([.top], 20)
                        
                        Text("Tasks Completed").padding([.top], 20).foregroundColor(Color.primary)
                        
                    }.frame(width:175, height: 175)
                    .background(Color.primary.colorInvert())
                    .cornerRadius(15)
                    .shadow(radius: 10, x: -5, y: 5)
                
                    VStack(spacing: 20){
                    
                            NavigationLink(destination: ListsTabView(vm: vm)){
                                VStack{
                                Text("Lists")
                                Image(systemName: "list.clipboard")
                                }
                                .foregroundColor(Color(light: Color.white, dark: Color.green))
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(width: 300, height: 100)
                            .background(Color(light: Color.green, dark: Color.black))
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        
                        
                            NavigationLink(destination: GoalView(vm: vm))
                            {
                                VStack{
                                    Text("Goals")
                                    Image(systemName: "scope")
                                }
                                .foregroundColor(Color(light: Color.white, dark: Color.blue))
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                            }
                            .frame(width: 300, height: 100)
                            .background(Color(light: Color.blue, dark: Color.black))
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        
                            NavigationLink(destination: RewardsView(vm: vm)){
                                VStack{
                                    Text("Rewards")
                                    Image(systemName: "trophy.circle")
                                }
                                .foregroundColor(Color(light: Color.white, dark: Color.red))
                                .font(.title)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            }
                            .frame(width: 300, height: 100)
                            .background(Color(light: Color.red, dark: Color.black))
                            .cornerRadius(25)
                            .shadow(radius: 10, x: -5, y: 5)
                            .buttonStyle(PressableButtonStyle())
                        
                        
                            //new
                        
                        NavigationLink(destination: MyCalendarView())
                        {
                            VStack{
                                Text("Calendar")
                                Image(systemName: "scope")
                            }
                            .foregroundColor(Color(light: Color.white, dark: Color.blue))
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                        }
                        .frame(width: 300, height: 100)
                        .background(Color(light: Color.blue, dark: Color.black))
                        .cornerRadius(25)
                        .shadow(radius: 10, x: -5, y: 5)
                        .buttonStyle(PressableButtonStyle())
                        
                        
                            //end of new
                            
                        
                    }.padding([.top], 30)
                    
                    Spacer(minLength: 50)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(light: Library.customBlue1, dark: Library.customGray1), Color(light: Library.customBlue2, dark: Library.customGray2)]), startPoint: .top, endPoint: .bottom)
                )
        
           
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        
        
    }
    


        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

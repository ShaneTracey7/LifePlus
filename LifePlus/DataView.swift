//
//  DataView.swift
//  LifePlus
//
//  Created by Coding on 2024-08-16.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    @State var sortSelection: Int = 0
    @State var source: String = ""
    @State var sources: [String] = []
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            
            
            Picker(selection: $source, label: Text("Source").foregroundColor(Color.secondary).font(.title3))
                {
                    Text("\("")").tag("")
                    ForEach(sources, id: \.self) { x in
                        Text("\(x)").tag(x)
                        }
                }
                .padding([.bottom], 5)
                .frame(height: 40)
                .frame(width: 200)
            
            ScrollView{
                
                VStack{
                    
                    Text(String(format: "%.1f %%", vm.getTotalCompletePercent(taskName: source)))
                        .font(.system(size: 32))
        
                    Text("Complete")
                        .font(.body)
                }
                .frame(width: 125, height: 100)
                .border(Library.lightblueColor, width: 10)
                .cornerRadius(25)
                .background(Color(light: Library.lightblueColor, dark: Color.black))
                .foregroundColor(Color(light: Color.white, dark: Library.blueColor))
            }
            .navigationTitle("Data")
            .toolbar {
                
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        .onAppear{
            
            sources = vm.getDailyDefaultTasks()
        }
        //.background(Color.white)
        }
    }


struct DataView_Previews: PreviewProvider {
    
    struct DataViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                DataView(vm: vm)
            }
        }
    
    static var previews: some View {
        DataViewContainer()
        
    }
}


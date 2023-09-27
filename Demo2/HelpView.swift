//
//  HelpView.swift
//  Demo2
//
//  Created by Coding on 2023-09-15.
//

import SwiftUI

struct HelpView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    
    var body: some View {
        
        VStack{
            
            Text("Help")
            Button {
                    withAnimation{
                        
                        vm.resetCoreData()
                        print("delete button was pressed")
                    }
            } label: {
                Text("Reset Core Data")
              }
        }
        
        
    }
}

struct HelpView_Previews: PreviewProvider {
    
    struct HelpViewContainer: View {
        @State var vm = CoreDataViewModel()
        
            var body: some View {
                HelpView(vm: self.vm)
            }
        }
    
    static var previews: some View {
        HelpViewContainer()
    }
}

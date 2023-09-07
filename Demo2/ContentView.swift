//
//  ContentView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text ("Life+")
            
            HStack {
                Button("+"){
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/){
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }

          
            
            List {
                HStack {
                    Text("item 1")
                    Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    
                }
                HStack {
                    Text("item 2")
                }
                HStack {
                    Text("item 3")
                }
                
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

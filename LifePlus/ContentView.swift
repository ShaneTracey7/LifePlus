//
//  ContentView.swift
//  Demo2
//
//  Created by Coding on 2023-09-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack() {
          Group {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 141, height: 138)
              .background(Color(red: 0.94, green: 0.71, blue: 0.12))
              .cornerRadius(15)
              .offset(x: -93.50, y: 70)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
              )
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 141, height: 138)
              .background(Color(red: 0.07, green: 0.80, blue: 0.23))
              .cornerRadius(15)
              .offset(x: 86.50, y: 69)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
              )
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 141, height: 138)
              .background(Color(red: 0.98, green: 0.06, blue: 0.89))
              .cornerRadius(15)
              .offset(x: 86.50, y: 240)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
              )
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 141, height: 138)
              .background(Color(red: 1, green: 0.09, blue: 0.09))
              .cornerRadius(15)
              .offset(x: -93.50, y: 240)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
              )
              
            Text("List")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(.white)
              .offset(x: -93, y: 32)
            Text("scores")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(.white)
              .offset(x: 86.50, y: 32)
            Text("goals")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(.white)
              .offset(x: 88.50, y: 198)
            Text("rewards")
              .font(Font.custom("Inter", size: 20))
              .foregroundColor(.white)
              .offset(x: -93.50, y: 205)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 190, height: 147)
              .background(.white)
              .cornerRadius(15)
              .offset(x: -6, y: -106.50)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 274, height: 76)
              .background(.white)
              .cornerRadius(15)
              .offset(x: 0, y: -318)
          }
        }
        .frame(width: 390, height: 844)
        .background(Color(red: 0.83, green: 0.89, blue: 0.97))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

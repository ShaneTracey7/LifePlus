//
//  PopUpWindowTask.swift
//  LifePlus
//
//  Created by Coding on 2023-10-10.
//

import SwiftUI

struct PopUpWindowTask: View {
    var title: String
    var message: String
    var buttonText: String
    @Binding var show: Bool
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0 : 0).edgesIgnoringSafeArea(.all)
                // PopUp Window
                
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(Library.customBlue2)
                    .frame(alignment: .center).cornerRadius(25)
                    
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30, alignment: .center)
                        .font(.title)
                        .foregroundColor(Color(light: Color.white, dark: Library.customBlue2))
                        .padding([.top],10)
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 20))
                        .foregroundColor(Color(light: Library.customBlue2, dark: Color.blue))
                        .frame(height:200)
                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.2)) {
                            show = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40, alignment: .center)
                            .foregroundColor(Color(light: Color.white, dark: Color.black))
                            .font(.body)
                            .cornerRadius(15)
                    }).buttonStyle(PressableButtonStyle())
                        .frame(width: 100)
                        .background(Library.customBlue2)
                        .cornerRadius(15)
                        .padding([.bottom], 10)
                        
                }
                //.frame(maxWidth: 280)
                .frame(width: 280)
                .background(Color(light: Library.customBlue1, dark: Color.black))
                .cornerRadius(25)
            }
        }
    }
}

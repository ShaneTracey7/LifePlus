//
//  PopUpWindow.swift
//  LifePlus
//
//  Created by Coding on 2023-10-04.
//

import SwiftUI

struct PopUpWindow: View {
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
                
                Rectangle().frame(maxWidth: 300, maxHeight: 300)
                    .foregroundColor(Color(light: Color.blue, dark: Color.secondary))
                    .frame(alignment: .center).cornerRadius(25)
                
                VStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30, alignment: .center)
                        .font(.title)
                        .foregroundColor(Color(light: Color.blue, dark: Color.secondary))
                        .background(Color.primary.colorInvert())
                        .padding([.top],10)
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(Color(light: Library.customBlue2, dark: Color.blue))
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
                        .background(Color(light: Color.blue, dark: Color.secondary))
                        .cornerRadius(15)
                        .padding([.bottom], 10)
                        
                }
                .frame(maxWidth: 280)
                .background(Color.primary.colorInvert())
                .cornerRadius(25)
            }
        }
    }
}


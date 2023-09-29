//
//  Library.swift
//  Demo2
//
//  Created by Coding on 2023-09-27.
//
// This class hosts all the static functions that used to be in Task, Rewards, Levelup and etc. structs

import Foundation
import SwiftUI

struct PressableButtonStyle: ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.2 : 1.0)
    }
}

/*
class LightSettings: ObservableObject {
    @Published var isDark = false
    
    func setIsDark(switch: Bool)
    {
        self.isDark.toggle()
    }
}
*/

class Library {
    
    
    
    static func getPercent(t: [TaskEntity]) -> Float{
        
        let temp = t.filter({$0.isComplete})
        let divisor = Float(temp.count)
        let dividend = Float(t.count)
        if(dividend <= 0.00)
        {
            return 0.00
        }
        else{
            let quotient = divisor/dividend
            return quotient
        }
        

    }
    
    static func updateLvl (points: Int) -> [Int]
     {
         var currentPoints: Int
         var levelPoints: Int
         
         var count: Int = 1
         var sum: Int = 0
         var result: Int  =  points //9633
         while (result >= 0)
         {

             if result > (count*100) + 900
             {
                 sum += (count*100) + 900
                 result -= (count*100 + 900)
                 count += 1
             }
             else
             {
                 result -= (count*100 + 900)
             }
         }
         
         levelPoints = (count * 100) + 900
         
         currentPoints = points - sum
         
         let lvl: Int = count
     return [currentPoints, levelPoints, lvl]
     }
    
    
    static func gaugeSet(points: Int) -> [Int] {
        
        var g1: Int = 0
        var g2: Int = 0
        var g3: Int = 0
        var g4: Int = 0
        
        if points <= 2000
        {
            g1 = points
        }
        else if points <= 4000
        {
            g1 = 2000
            g2 = points - 2000
        }
        else if points <= 8000{
            g1 = 2000
            g2 = 2000
            g3 = points - 4000
        }
        else if points <= 16000{
            g1 = 2000
            g2 = 2000
            g3 = 4000
            g4 = points - 8000
        }
        else // >16000
        {
            g1 = 2000
            g2 = 2000
            g3 = 4000
            g4 = 8000
        }
        
        let arr: [Int] = [g1,g2,g3,g4]
        return arr
    }
    
}

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


class Library {
    
    
    //Colors
    static let customBlue1: Color = Color(red: 0.85, green: 0.90, blue: 1)
    static let customBlue2: Color = Color(red: 0.50, green: 0.70, blue: 1)
    
    static let customGray1: Color = Color(white: 0.3)
    static let customGray2: Color = Color(white: 0.05)
    
    static let blueColor: Color = Color(red: 0.65, green: 0.75, blue: 0.95)
    static let greenColor: Color = Color(red: 0.55, green: 0.95, blue: 0.65)
    static let redColor: Color = Color(red: 0.95, green: 0.55, blue: 0.65)
    
    static let lightblueColor: Color = Color(red: 0.78, green: 0.90, blue: 1.14)
    static let lightgreenColor: Color = Color(red: 0.78, green: 1.14, blue: 0.90)
    static let lightredColor: Color = Color(red: 1.14, green: 0.78, blue: 0.90)
    
    //returns today with hours = 0, mins = 0, and sec = 1
    static func firstSecondOfToday() -> Date{
        let currentDate = Date()
       var components = DateComponents()
       components.year = Calendar.current.dateComponents([.year], from: currentDate).year ?? 1
       components.month = Calendar.current.dateComponents([.month], from: currentDate).month ?? 1
       components.day = Calendar.current.dateComponents([.day], from: currentDate).day ?? 1
       components.hour = 0
       components.minute = 0
       components.second = 1
        let date = Calendar.current.date(from: components)//?.addingTimeInterval(86400)
        
        return date ?? Date()
    }
    
    static func getDate(tasklist: ListEntity) -> [Date]
    {
       let date1 = tasklist.startDate ?? Date()
        let date2 = tasklist.endDate ?? Date()
        
        return [date1, date2]
    }
    
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

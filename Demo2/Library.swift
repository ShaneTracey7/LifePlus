//
//  Library.swift
//  Demo2
//
//  Created by Coding on 2023-09-27.
//
// This class hosts all the static functions that used to be in Task, Rewards, Levelup and etc. structs

import Foundation

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
    
    
}

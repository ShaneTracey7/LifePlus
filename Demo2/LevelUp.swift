//
//  LevelUp.swift
//  Demo2
//
//  Created by Coding on 2023-09-25.
//

import Foundation

struct LevelUp {
    
    var level: Int
    var points: Int
    
    init(level: Int, points: Int)
    {
        self.level = level
        self.points = points
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

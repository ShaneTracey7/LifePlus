//
//  Reward.swift
//  Demo2
//
//  Created by Coding on 2023-09-21.
//

import Foundation

struct Reward: Identifiable{
    
    let id: UUID
    var name: String // name of reward
    var image: String // string of systemName of image
    var price: Int //how much it costs
    var isPurchased: Bool // if user has purchased reward
    var isUsed: Bool // if user has used reward
    

    init(id: UUID = UUID(), name: String, image: String, price: Int, isPurchased: Bool, isUsed: Bool){
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.isPurchased = isPurchased
        self.isUsed = isUsed
        
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

extension Reward {
    static let initialData: [Reward] =
    [
        //2000
        Reward(name: "Get a Tasty Drink", image: "cup.and.saucer", price: 2000, isPurchased: false, isUsed: false),
        Reward(name: "Get a Tasty Treat", image: "birthday.cake", price: 2000, isPurchased: false, isUsed: false),
        //4000
        Reward(name: "Get some fast food", image: "takeoutbag.and.cup.and.straw", price: 4000, isPurchased: false, isUsed: false),
        Reward(name: "Play 1 hour of video games", image: "gamecontroller", price: 4000, isPurchased: false, isUsed: false),
        Reward(name: "Sleep-in an extra hour", image: "bed.double", price: 4000, isPurchased: false, isUsed: false),
        //8000
        Reward(name: "Eat out / Get takeout", image: "fork.knife", price: 8000, isPurchased: false, isUsed: false),
        Reward(name: "Go see a movie in theatres", image: "popcorn", price: 8000, isPurchased: false, isUsed: false)
        //16000
        
    ]
}




 

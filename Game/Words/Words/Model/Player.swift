//
//  Player.swift
//  Words
//
//  Created by Roman Khancha on 23.11.2023.
//

import Foundation

struct Player {
    
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}

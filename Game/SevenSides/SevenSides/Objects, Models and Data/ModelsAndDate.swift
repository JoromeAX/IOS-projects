//
//  ModelsAndDate.swift
//  SevenSides
//
//  Created by Roman Khancha on 23.05.2023.
//

import Foundation
import SpriteKit

//MARK: - Sides and ball info

enum colorType {
    
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case Green
}

let colorWheelOrder: [colorType] = [.Red, .Orange, .Yellow, .Green, .Blue, .Purple, .Pink]

var sidePositions:[CGPoint] = []

//MARK: - Game state

enum gameState {
    case preGame
    case inGame
    case afterGame
}

//MARK: - Physics Categories

struct PhysicsCategories {
    
    static let none: UInt32 = 0x1 << 0
    static let ball: UInt32 = 0x1 << 1
    static let side: UInt32 = 0x1 << 2
}

//MARK: - Score System

var score = 0

//MARK: - Level System

var ballMovmentSpeed: TimeInterval = 2

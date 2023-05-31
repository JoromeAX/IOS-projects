//
//  SideObject.swift
//  SevenSides
//
//  Created by Roman Khancha on 23.05.2023.
//

import Foundation
import SpriteKit

class Side: SKSpriteNode {
    
    let type: colorType
    
    init(type: colorType) {
        
        self.type = type
        let sideTexture = SKTexture(imageNamed: "side_\(self.type)")
        
        super.init(texture: sideTexture, color: SKColor.clear, size: sideTexture.size())
        
        //MARK: - Physics Body
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.side
        self.physicsBody?.collisionBitMask = PhysicsCategories.none
        self.physicsBody?.contactTestBitMask = PhysicsCategories.ball
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

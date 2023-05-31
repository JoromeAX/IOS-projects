//
//  BallObject.swift
//  SevenSides
//
//  Created by Roman Khancha on 23.05.2023.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    let type: colorType
    
    var isActive = true
    
    init() {
        
        let randomTypeIndex = Int(arc4random_uniform(7))
        self.type = colorWheelOrder[randomTypeIndex]
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")
        
        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
        //MARK: - Physics Body
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 55)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategories.ball
        self.physicsBody?.collisionBitMask = PhysicsCategories.none
        self.physicsBody?.contactTestBitMask = PhysicsCategories.side
        
        self.setScale(0)
        let scaleIn = SKAction.scale(to: 1, duration: 0.2)
        let randomSideIndex = Int(arc4random_uniform(7))
        let sideToMoveTo = sidePositions[randomSideIndex]
        let moveToSide = SKAction.move(to: sideToMoveTo, duration: ballMovmentSpeed)
        let ballSequence = SKAction.sequence([scaleIn, moveToSide])
        self.run(ballSequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deleteBall() {
        
        self.isActive = false
        self.removeAllActions()
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let delete = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, delete])
        self.run(deleteSequence)
    }
    
    func flash() {
        
        self.removeAllActions()
        self.isActive = false
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let flashSequence = SKAction.sequence([fadeOut, fadeIn])
        let repeatFlash = SKAction.repeat(flashSequence, count: 3)
        
        self.run(repeatFlash)
    }
}

//
//  GameScene.swift
//  SoloMission
//
//  Created by Roman Khancha on 03.05.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    
    let bulletSound = SKAction.playSoundFileNamed("shot.mp3", waitForCompletion: false)
    
    let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    let gameArea: CGRect
    
    struct PhysicsCategories {
        
        static let player: UInt32 = 0x1 << 1
        static let bullet: UInt32 = 0x1 << 2
        static let enemy: UInt32 = 0x1 << 3
    }
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        addChild(background)
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysicsCategories.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = PhysicsCategories.enemy
        addChild(player)
        
        startNewLevel()
    }
    
    //MARK: - SKPhysicsContactDelegate Methods
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.player && contact.bodyB.categoryBitMask == PhysicsCategories.enemy {
            //if player hit enemy
            if let player = contact.bodyA.node as? SKSpriteNode, let enemy = contact.bodyB.node as? SKSpriteNode {
                
                spawnExplosion(to: player.position)
                spawnExplosion(to: enemy.position)
                
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
            }
        }
        if contact.bodyA.categoryBitMask == PhysicsCategories.bullet && contact.bodyB.categoryBitMask == PhysicsCategories.enemy {
            //if bullet hit enemy
            if let enemy = contact.bodyB.node as? SKSpriteNode {
                if enemy.position.y < self.size.height {
                    
                    spawnExplosion(to: enemy.position)
                    
                    contact.bodyA.node?.removeFromParent()
                    contact.bodyB.node?.removeFromParent()
                }
            }
        }
    }
    
    func random() -> CGFloat {
        CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max: CGFloat) -> CGFloat {
        random() * (max - min) + min
    }
    
    func fireBullet() {
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = PhysicsCategories.bullet
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.contactTestBitMask = PhysicsCategories.enemy
        addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequense = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequense)
    }
    
    func spawnEnemy() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = PhysicsCategories.enemy
        enemy.physicsBody?.collisionBitMask = 0
        enemy.physicsBody?.contactTestBitMask = PhysicsCategories.player | PhysicsCategories.bullet
        addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let sequenceEnemy = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(sequenceEnemy)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
    }
    
    func spawnExplosion(to spawnPosition: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        explosion.run(explosionSequence)
    }
    
    func startNewLevel() {
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSeqence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSeqence)
        run(spawnForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fireBullet()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragget = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragget
            
            if player.position.x >= gameArea.maxX - player.size.width/2 {
                
                player.position.x = gameArea.maxX - player.size.width/2
            } else if player.position.x <= gameArea.minX + player.size.width/2 {
                
                player.position.x = gameArea.minX + player.size.width/2
            }
            
        }
    }
}

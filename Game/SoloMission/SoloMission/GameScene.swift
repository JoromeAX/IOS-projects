//
//  GameScene.swift
//  SoloMission
//
//  Created by Roman Khancha on 03.05.2023.
//

import SpriteKit
import GameplayKit

var gameScore = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var lastUpdateTime: TimeInterval = 0
    
    var deltaFrameTime: TimeInterval = 0
    
    var amountToMovePerSecond: CGFloat = 600
    
    var levelNumber = 0
    
    var livesNumber = 3
    
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let tapToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    
    let bulletSound = SKAction.playSoundFileNamed("shot.mp3", waitForCompletion: false)
    
    let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
    
    let gameArea: CGRect
    
    enum gameState {
        case preGame
        case inGame
        case afterGame
    }
    
    var currentGameState = gameState.preGame
    
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
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: "background")
            background.name = "background"
            background.size = self.size
            background.anchorPoint = CGPoint(x: 0.5, y: 0)
            background.position = CGPoint(x: self.size.width/2, y: self.size.height * CGFloat(i))
            background.zPosition = 0
            addChild(background)
        }
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: 0 - player.size.height)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysicsCategories.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = PhysicsCategories.enemy
        addChild(player)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = .white
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 5
        addChild(scoreLabel)
        
        livesLabel.text = "Lives: \(livesNumber)"
        livesLabel.fontSize = 70
        livesLabel.fontColor = .white
        livesLabel.horizontalAlignmentMode = .right
        livesLabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height + livesLabel.frame.size.height)
        livesLabel.zPosition = 5
        addChild(livesLabel)
        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height * 0.9, duration: 0.3)
        scoreLabel.run(moveOnToScreenAction)
        livesLabel.run(moveOnToScreenAction)
        
        tapToStartLabel.text = "Tap To Start"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = .white
        tapToStartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        tapToStartLabel.zPosition = 1
        tapToStartLabel.alpha = 0
        addChild(tapToStartLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        tapToStartLabel.run(fadeInAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        } else {
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBacground = amountToMovePerSecond * CGFloat(deltaFrameTime)
        
        self.enumerateChildNodes(withName: "background") {
            background, stop in
            
            if self.currentGameState == .inGame {
                background.position.y -= amountToMoveBacground
            }
            
            if background.position.y <  -self.size.height {
                background.position.y += self.size.height * 2
            }
        }
    }
    
    func addScore() {
        
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if gameScore == 10 || gameScore == 25 || gameScore == 50 {
            startNewLevel()
        }
        if gameScore % 5 == 0 {
            livesNumber += 1
            livesLabel.text = "Lives: \(livesNumber)"
        }
    }
    
    func loseALife() {
        
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence )
        
        if livesNumber == 0 {
            gameOver()
        }
    }
    
    func startGame() {
        
        currentGameState = .inGame
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequnce = SKAction.sequence([fadeOutAction, deleteAction])
        tapToStartLabel.run(deleteSequnce)
        
        let moveShipOnScreenAction = SKAction.moveTo(y: self.size.height * 0.2, duration: 0.5)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameAction = SKAction.sequence([moveShipOnScreenAction, startLevelAction])
        player.run(startGameAction)
    }
    
    func gameOver() {
        
        currentGameState = .afterGame
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "bullet") {
            bullet, stop in
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "enemy") {
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequnce = SKAction.sequence([waitToChangeScene, changeSceneAction])
        run(changeSceneSequnce)
    }
    
    func changeScene() {
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        self.view!.presentScene(sceneToMoveTo, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.player && contact.bodyB.categoryBitMask == PhysicsCategories.enemy {
            //if player hit enemy
            if let player = contact.bodyA.node as? SKSpriteNode, let enemy = contact.bodyB.node as? SKSpriteNode {
                
                spawnExplosion(to: player.position)
                spawnExplosion(to: enemy.position)
                
                player.removeFromParent()
                enemy.removeFromParent()
                gameOver()
            }
        }
        if contact.bodyA.categoryBitMask == PhysicsCategories.bullet && contact.bodyB.categoryBitMask == PhysicsCategories.enemy {
            //if bullet hit enemy
            if let bullet = contact.bodyA.node as? SKSpriteNode, let enemy = contact.bodyB.node as? SKSpriteNode {
                if enemy.position.y < self.size.height {
                    
                    addScore()
                    spawnExplosion(to: enemy.position)
                    
                    bullet.removeFromParent()
                    enemy.removeFromParent()
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
        bullet.name = "bullet"
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
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
        enemy.name = "enemy"
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = PhysicsCategories.enemy
        enemy.physicsBody?.collisionBitMask = 0
        enemy.physicsBody?.contactTestBitMask = PhysicsCategories.player | PhysicsCategories.bullet
        addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 2.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let sequenceEnemy = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        if currentGameState == .inGame {
            enemy.run(sequenceEnemy)
        }
        
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
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 2
        case 2: levelDuration = 1.5
        case 3: levelDuration = 1
        case 4: levelDuration = 0.8
        default:
            levelDuration = 0.5
            print("Cannot find the level")
        }
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSeqence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSeqence)
        run(spawnForever, withKey: "spawningEnemies")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .preGame {
            startGame()
        } else if currentGameState == .inGame {
            fireBullet()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragget = pointOfTouch.x - previousPointOfTouch.x
            
            if currentGameState == .inGame {
                player.position.x += amountDragget
            }
            if player.position.x >= gameArea.maxX - player.size.width/2 {
                
                player.position.x = gameArea.maxX - player.size.width/2
            } else if player.position.x <= gameArea.minX + player.size.width/2 {
                
                player.position.x = gameArea.minX + player.size.width/2
            }
            
        }
    }
}

//
//  GameScene.swift
//  SchoolhouseSkateboarder
//
//  Created by Roman Khancha on 01.05.2023.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    
    static let skater: UInt32 = 0x1 << 0
    static let brick: UInt32 = 0x1 << 1
    static let gem: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum BrickLevel: CGFloat {
        case low = 0.0
        case high = 100.0
    }
    
    enum GameState {
        case notRuning
        case runing
    }
    
    var bricks = [SKSpriteNode]()
    
    var gems = [SKSpriteNode]()
    
    var bricksSize = CGSize.zero
    
    var brickLevel = BrickLevel.low
    
    var gameState = GameState.notRuning
    
    var scrollSpeed: CGFloat = 5
    
    let startingScrollSpeed: CGFloat = 5.0
    
    let gravitySpeed: CGFloat = 1.5
    
    var score = 0
    
    var bestScore = 0
    
    var lastScoreUpdateTime: TimeInterval = 0.0
    
    var lastUpdateTime: TimeInterval?
    
    let skater = Skater(imageNamed: "skater")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.contactDelegate = self
        
        anchorPoint = CGPoint.zero
        
        let background = SKSpriteNode(imageNamed: "background")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        addChild(background)
        setupLabels()
        skater.setupPhysicsBody()
        addChild(skater)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handlerTap(tapGesture:)))
        view.addGestureRecognizer(tapGesture)
        
        let menuBackgroundColor = UIColor.black.withAlphaComponent(0.4)
        let menuLayer = MenuLayer(color: menuBackgroundColor, size: frame.size)
        menuLayer.anchorPoint = CGPoint(x: 0, y: 0)
        menuLayer.position = CGPoint(x: 0, y: 0)
        menuLayer.zPosition = 30
        menuLayer.name = "menuLayer"
        menuLayer.display(message: "Tap to play", score: nil)
        addChild(menuLayer)
        
    }
    
    func resetSkater() {
        
        let skaterX = frame.midX / 2.0
        let skaterY = skater.frame.height / 2.0 + 64.0
        skater.position = CGPoint(x: skaterX, y: skaterY)
        skater.zPosition = 10
        skater.minimumY = skaterY
        skater.zRotation = 0
        skater.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        skater.physicsBody?.angularVelocity = 0
    }
    
    func setupLabels() {
        
        let scoreTextLabel = SKLabelNode(text: "Score")
        scoreTextLabel.position = CGPoint(x: 14.0, y: frame.size.height - 20.0)
        scoreTextLabel.horizontalAlignmentMode = .left
        scoreTextLabel.fontName = "Bold"
        scoreTextLabel.fontSize = 14
        scoreTextLabel.zPosition = 20
        addChild(scoreTextLabel)
        
        let scoreLabel = SKLabelNode(text: "0")
        scoreLabel.name = "scoreLabel"
        scoreLabel.position = CGPoint(x: 14.0, y: frame.size.height - 40)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontName = "Bold"
        scoreLabel.fontSize = 18
        scoreLabel.zPosition = 20
        addChild(scoreLabel)
        
        let bestScoreTexTtLabel = SKLabelNode(text: "Best Score")
        bestScoreTexTtLabel.position = CGPoint(x: frame.size.width - 14, y: frame.size.height - 20)
        bestScoreTexTtLabel.horizontalAlignmentMode = .right
        bestScoreTexTtLabel.fontName = "Bold"
        bestScoreTexTtLabel.fontSize = 14
        bestScoreTexTtLabel.zPosition = 20
        addChild(bestScoreTexTtLabel)
        
        let bestScoreLabel = SKLabelNode(text: "0")
        bestScoreLabel.name = "bestScoreLabel"
        bestScoreLabel.position = CGPoint(x: frame.size.width - 14, y: frame.size.height - 40)
        bestScoreLabel.horizontalAlignmentMode = .right
        bestScoreLabel.fontName = "Bold"
        bestScoreLabel.fontSize = 18
        bestScoreLabel.zPosition = 20
        addChild(bestScoreLabel)
    }
    
    func updateScoreLabelText() {
        
        if let scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode {
            scoreLabel.text = String(format: "%04d", score)
        }
    }
    
    func updateBestScoreLabelText() {
        
        if let bestScoreLabel = childNode(withName: "bestScoreLabel") as? SKLabelNode {
            bestScoreLabel.text = String(format: "%04d", bestScore)
        }
    }
    
    func startGame() {
        
        gameState = .runing
        resetSkater()
        score = 0
        scrollSpeed = startingScrollSpeed
        brickLevel = .low
        lastUpdateTime = nil
        
        for brick in bricks {
            brick.removeFromParent()
        }
        bricks.removeAll(keepingCapacity: true)
        for gem in gems {
            removeGem(gem)
        }
    }
    
    func gameOver() {
        
        gameState = .notRuning
        if score > bestScore {
            bestScore = score
            updateBestScoreLabelText()
        }
        let menuBackgroundColor = UIColor.black.withAlphaComponent(0.4)
        let menuLayer = MenuLayer(color: menuBackgroundColor, size: frame.size)
        menuLayer.anchorPoint = CGPoint(x: 0, y: 0)
        menuLayer.position = CGPoint(x: 0, y: 0)
        menuLayer.zPosition = 30
        menuLayer.name = "menuLayer"
        menuLayer.display(message: "Game over", score: score)
        addChild(menuLayer)
    }
    
    func spawnBrick(atPosition position: CGPoint) -> SKSpriteNode {
        
        let brick = SKSpriteNode(imageNamed: "sidewalk")
        brick.position = position
        brick.zPosition = 8
        addChild(brick)
        bricksSize = brick.size
        bricks.append(brick)
        
        let center = brick.centerRect.origin
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size, center: center)
        brick.physicsBody?.affectedByGravity = false
        brick.physicsBody?.categoryBitMask = PhysicsCategory.brick
        brick.physicsBody?.collisionBitMask = 0
        
        return brick
    }
    
    func spawnGems(atPosition position: CGPoint) {
        
        let gem = SKSpriteNode(imageNamed: "gem")
        gem.position = position
        gem.zPosition = 9
        addChild(gem)
        gem.physicsBody = SKPhysicsBody(rectangleOf: gem.size, center: gem.centerRect.origin)
        gem.physicsBody?.categoryBitMask = PhysicsCategory.gem
        gem.physicsBody?.affectedByGravity = false
        gems.append(gem)
    }
    
    func removeGem(_ gem: SKSpriteNode) {
        
        gem.removeFromParent()
        if let gemIndex = gems.firstIndex(of: gem) {
            gems.remove(at: gemIndex)
        }
    }
    
    func updateBricks(withScrollAmount currentScrollAmount: CGFloat) {
        
        var farthestRightBricksX: CGFloat = 0
        
        for brick in bricks {
            
            let newX = brick.position.x - currentScrollAmount
            
            if newX < -bricksSize.width {
                
                brick.removeFromParent()
                
                if let brickIndex = bricks.firstIndex(of: brick) {
                    bricks.remove(at: brickIndex)
                }
            } else {
                brick.position = CGPoint(x: newX, y: brick.position.y)
                
                if brick.position.x > farthestRightBricksX {
                    farthestRightBricksX = brick.position.x
                }
            }
        }
        
        while farthestRightBricksX < frame.width {
            
            var brickX = farthestRightBricksX + bricksSize.width + 1
            let brickY = (bricksSize.height / 2) +  brickLevel.rawValue
            
            let randomNumber = arc4random_uniform(99)
            
            if randomNumber < 2 &&  score > 10 {
                
                let gap = 20 * scrollSpeed
                brickX += gap
                
                let randomGemAmount = CGFloat(arc4random_uniform(150))
                let newGemY = brickY + skater.size.height + randomGemAmount
                let newGemX = brickX - gap / 2.0
                spawnGems(atPosition: CGPoint(x: newGemX, y: newGemY))
            } else if randomNumber < 4 && score > 20 {
                
                if brickLevel == .high {
                    brickLevel = .low
                } else {
                    brickLevel = .high
                }
            }
            
            let newBrick = spawnBrick(atPosition: CGPoint(x: brickX, y: brickY))
            farthestRightBricksX = newBrick.position.x
        }
    }
    
    func updateGems(withScrollAmount currentScrollAmount: CGFloat) {
        
        for gem in gems {
            
            let thisGemX = gem.position.x - currentScrollAmount
            gem.position = CGPoint(x: thisGemX, y: gem.position.y)
            
            if gem.position.x < 0.0 {
                removeGem(gem)
            }
        }
    }
    
    func updateSkater() {
        
        if let velocityY = skater.physicsBody?.velocity.dy {
            if velocityY < -100.0 || velocityY > 100 {
                skater.isOnGround = false
            }
        }
        let isOffScreen = skater.position.y < 0.0 || skater.position.x < 0.0
        let maxRotation = CGFloat(GLKMathDegreesToRadians(85.0))
        let isTippedOver = skater.zRotation > maxRotation || skater.zRotation < -maxRotation
        if isOffScreen || isTippedOver {
            gameOver()
        }
    }
    
    func updateScore(withCurrentTime currentTime: TimeInterval) {
        
        let elepsedTime = currentTime - lastScoreUpdateTime
        if elepsedTime > 1.0 {
            
            score += Int(scrollSpeed)
            lastScoreUpdateTime = currentTime
            updateScoreLabelText()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if gameState != .runing {
            return
        }
        scrollSpeed += 0.01
        var elapsedTime: TimeInterval = 0.0
        if let lastTimeStamp = lastUpdateTime {
            elapsedTime = currentTime - lastTimeStamp
        }
        lastUpdateTime = currentTime
        
        let expectedElapsedTime: TimeInterval = 1.0 / 60.0
        
        let scrollAdjustment = CGFloat(elapsedTime / expectedElapsedTime)
        let currentScrollAmount = scrollSpeed * scrollAdjustment
        
        updateBricks(withScrollAmount: currentScrollAmount)
        updateSkater()
        updateGems(withScrollAmount: currentScrollAmount)
        updateScore(withCurrentTime: currentTime)
    }
    
    @objc func handlerTap(tapGesture: UITapGestureRecognizer) {
        
        if gameState == .runing {
            if skater.isOnGround {
                
                skater.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 260))
                run(SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false))
            }
        } else {
            if let menuLayer = childNode(withName: "menuLayer") as? SKSpriteNode {
                menuLayer.removeFromParent()
            }
            startGame()
        }
    }
    
    //MARK: - SKPhysicsContactDelegate Methods
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.skater && contact.bodyB.categoryBitMask == PhysicsCategory.brick {
            
            if let velocityY = skater.physicsBody?.velocity.dy{
                if !skater.isOnGround && velocityY < 100.0 {
                    
                    skater.createSparks()
                }
            }
            skater.isOnGround = true
        } else if contact.bodyA.categoryBitMask == PhysicsCategory.skater && contact.bodyB.categoryBitMask == PhysicsCategory.gem {
            if let gem = contact.bodyB.node as? SKSpriteNode {
                removeGem(gem)
                score += 50
                updateScoreLabelText()
                run(SKAction.playSoundFileNamed("gem.wav", waitForCompletion: false))
            }
        }
    }
}

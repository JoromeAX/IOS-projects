//
//  GameScene.swift
//  SevenSides
//
//  Created by Roman Khancha on 21.05.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playCorrectSound = SKAction.playSoundFileNamed("Correct sound.mp3", waitForCompletion: false)
    
    let playWrongSound = SKAction.playSoundFileNamed("Wrong side.mp3", waitForCompletion: false)
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let scoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
    
    let highScoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    var currentGameState = gameState.preGame
    
    var colorWheelBase = SKShapeNode()
    
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreesToRadiant(degrees: 360 / 7), duration: 0.2)
    
    override func didMove(to view: SKView) {
        
        score = 0
        
        ballMovmentSpeed = 2
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        colorWheelBase = SKShapeNode(rectOf: CGSize(width: self.size.width * 0.8, height: self.size.width * 0.8))
        colorWheelBase.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        colorWheelBase.strokeColor = .clear
        addChild(colorWheelBase)
        
        prepColorWheel()
        
        tapToStartLabel.text = "Tap to Start"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = .darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.1)
        addChild(tapToStartLabel)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 225
        scoreLabel.fontColor = .darkGray
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.85)
        addChild(scoreLabel)
        
        highScoreLabel.text = "Best: \(highScore)"
        highScoreLabel.fontSize = 100
        highScoreLabel.fontColor = .darkGray
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
        addChild(highScoreLabel)
        
    }
    
    func prepColorWheel() {
        
        for i in 0...6 {
            let side = Side(type: colorWheelOrder[i])
            let basePosition = CGPoint(x: self.size.width / 2, y: self.size.height * 0.25)
            side.position = convert(basePosition, to: colorWheelBase)
            side.zRotation = -colorWheelBase.zRotation
            colorWheelBase.addChild(side)
            
            colorWheelBase.zRotation += convertDegreesToRadiant(degrees: 360 / 7)
        }
        
        for side in colorWheelBase.children {
            
            let sidePosition = side.position
            let positionInScene = convert(sidePosition, from: colorWheelBase)
            sidePositions.append(positionInScene)
        }
    }
    
    func spawnBall() {
        
        let ball = Ball()
        ball.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(ball)
    }
    
    func startGame() {
        
        spawnBall()
        currentGameState = .inGame
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .preGame {
            
            startGame()
        } else if currentGameState == .inGame {
            
            colorWheelBase.run(spinColorWheel)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let ball: Ball
        let side: Side
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.ball {
            
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
        } else {
            
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        
        if ball.isActive == true {
            
            checkMatch(ball: ball, side: side)
        }
    }
    
    func checkMatch(ball:  Ball, side: Side) {
        
        if ball.type == side.type {
            
            correctMacth(ball: ball)
        } else {
            
            wrongMacth(ball: ball)
        }
    }
    
    func correctMacth(ball: Ball) {
        
        ball.deleteBall()
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        switch score {
        case 5: ballMovmentSpeed = 1.9
        case 15: ballMovmentSpeed = 1.8
        case 25: ballMovmentSpeed = 1.6
        case 40: ballMovmentSpeed = 1.4
        case 60: ballMovmentSpeed = 1.2
        case 80: ballMovmentSpeed = 1.1
        case 100: ballMovmentSpeed = 1
        default: print("")
        }
        
        spawnBall()
        
        if score > highScore {
            highScoreLabel.text = "Best: \(score)"
        }

        self.run(playCorrectSound)
    }
    
    func wrongMacth(ball: Ball) {
        
        if score > highScore {
            
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
        
        ball.flash()
        self.run(playWrongSound)
        currentGameState = .afterGame
        colorWheelBase.removeAllActions()
        
        let waitToChangeScene = SKAction.wait(forDuration: 3)
        let changeScene = SKAction.run {
            
            let sceneToMoveTo = SKScene(fileNamed: "GameOverScene")!
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        }
        let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
        self.run(sceneChangeSequence)
    }
    
}

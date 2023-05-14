//
//  GameOverScene.swift
//  SoloMission
//
//  Created by Roman Khancha on 12.05.2023.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 200
        gameOverLabel.fontColor = .white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
        
        let defaults = UserDefaults()
        var highScore = defaults.integer(forKey: "highScoreSaved")
        
        if gameScore > highScore {
            
            highScore = gameScore
            defaults.setValue(highScore, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = .white
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.45)
        highScoreLabel.zPosition = 1
        addChild(highScoreLabel)
        
        let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
        restartLabel.text = "Touch to Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = .white
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        restartLabel.zPosition = 1
        addChild(restartLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        self.view!.presentScene(sceneToMoveTo, transition: SKTransition.fade(withDuration: 0.5))
    }
}

//
//  GameOverScene.swift
//  SevenSides
//
//  Created by Roman Khancha on 25.05.2023.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let scoreLabel: SKLabelNode = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score:  \(score)"
        
        let highScoreLabel: SKLabelNode = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        let highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
        highScoreLabel.text = "High Score:  \(highScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
    }
}

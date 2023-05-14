//
//  MainMenuScene.swift
//  SoloMission
//
//  Created by Roman Khancha on 14.05.2023.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        addChild(background)
        
        let gameByLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameByLabel.text = "JoromeAX"
        gameByLabel.fontSize = 50
        gameByLabel.fontColor = .white
        gameByLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.78)
        gameByLabel.zPosition = 1
        addChild(gameByLabel)
        
        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Solo"
        gameName1.fontSize = 200
        gameName1.fontColor = .white
        gameName1.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameName1.zPosition = 1
        addChild(gameName1)
        
        let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
        gameName2.text = "Mission"
        gameName2.fontSize = 200
        gameName2.fontColor = .white
        gameName2.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.625)
        gameName2.zPosition = 1
        addChild(gameName2)
        
        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = .white
        startGame.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        startGame.zPosition = 1
        addChild(startGame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        self.view!.presentScene(sceneToMoveTo, transition: SKTransition.fade(withDuration: 0.5))
    }
}

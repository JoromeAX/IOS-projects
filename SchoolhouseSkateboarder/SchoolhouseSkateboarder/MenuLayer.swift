//
//  MenuLayer.swift
//  SchoolhouseSkateboarder
//
//  Created by Roman Khancha on 08.05.2023.
//

import UIKit
import SpriteKit

class MenuLayer: SKSpriteNode {
    
    func display(message: String, score: Int?) {
        
        let messagelabel = SKLabelNode(text: message)
        let messageX = -frame.width
        let messageY = frame.height / 2
        messagelabel.position = CGPoint(x: messageX, y: messageY)
        messagelabel.horizontalAlignmentMode = .center
        messagelabel.fontName = "Bold"
        messagelabel.fontSize = 48
        messagelabel.zPosition = 20
        addChild(messagelabel)
        let finalX = frame.width / 2
        let messageAction = SKAction.moveTo(x: finalX, duration: 0.3)
        messagelabel.run(messageAction)
        
        if let scoreToDisplay = score {
            
            let scoreString = String(format: "Score:%04d", scoreToDisplay)
            let scoreLabel = SKLabelNode(text: scoreString)
            let scoreLabelX = frame.width
            let scoreLabelY = messagelabel.position.y - messagelabel.frame.height
            scoreLabel.position = CGPoint(x: scoreLabelX, y: scoreLabelY)
            scoreLabel.horizontalAlignmentMode = .center
            scoreLabel.fontName = "Bold"
            scoreLabel.fontSize = 32
            scoreLabel.zPosition = 20
            addChild(scoreLabel)
            let scoreAction = SKAction.moveTo(x: finalX, duration: 0.3)
            scoreLabel.run(scoreAction)
        }
    }
}

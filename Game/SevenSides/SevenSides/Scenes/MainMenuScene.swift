//
//  MainMenuScene.swift
//  SevenSides
//
//  Created by Roman Khancha on 25.05.2023.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sceneMoveTo = GameScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneMoveTo, transition: sceneTransition)
    }
}

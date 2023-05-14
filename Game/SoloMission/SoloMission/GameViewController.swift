//
//  GameViewController.swift
//  SoloMission
//
//  Created by Roman Khancha on 03.05.2023.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    
    override func viewDidLoad() {
        
        let filePath = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")
        let audioURL = URL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            return print("Cannot Find The Audio")
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
        
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
                
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//
//  GameViewController.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var level : Level!
    var scene : GameScene!
    
    func beginGame(){
        shuffle()
    }
    
    func shuffle(){
        let newRoom = level.shuffle()
        scene.addSprite(jarrons: newRoom)
    }
    
    override func viewDidLoad() {
        let skView = view as! SKView
        
        scene = GameScene(size: self.view.bounds.size)
        scene.scaleMode = .aspectFill
        level = Level()
        scene.level = level
        scene.addTile()
        beginGame()
        skView.presentScene(scene)
    }
}

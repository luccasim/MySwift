//
//  GameScene.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var level : Level!
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 36.0

    var gameLayer = SKNode()
    var jarronLayer = SKNode()
    let tileLayer = SKNode()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x:0.5, y:0.5)
       
        let background = SKSpriteNode(imageNamed: "boat")
        background.size = size
        addChild(background)
        addChild(gameLayer)
        
        let layerPosition = CGPoint(x: -TileWidth * CGFloat(numColumns / 2),y: -TileHeight * CGFloat(numRows / 2))
        tileLayer.position = layerPosition
        jarronLayer.position = layerPosition
        gameLayer.addChild(tileLayer)
        gameLayer.addChild(jarronLayer)
        
    }
    
    func pointFor(column: Int, row:Int) -> CGPoint {
        let width = CGFloat(row) * TileWidth + TileWidth / 2
        let height = CGFloat(column) * TileHeight + TileWidth / 2
        return CGPoint(x: width, y: height)
    }
    
    func addTile()
    {
        for row in 0..<numRows {
            for col in 0..<numColumns {
                let tileSprite = SKSpriteNode(imageNamed: "Tile")
                tileSprite.size = CGSize(width: TileWidth, height: TileHeight)
                tileSprite.position = pointFor(column:  col, row: row)
                tileLayer.addChild(tileSprite)
            }
        }
    }
    
    var bombSet = Set<Jarron>()
    
    func addSprite(jarrons: Set<Jarron>){
        for elem in jarrons {
            if let sprite = elem.sprite {
                sprite.size = CGSize(width: TileWidth, height: TileHeight)
                sprite.position = pointFor(column: elem.column, row: elem.row)
                sprite.name = elem.spriteName
                jarronLayer.addChild(sprite)
            }
            if elem.content == .bomb {
                bombSet.insert(elem)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

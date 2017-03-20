//
//  extensionGameScene.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation
import UIKit

// #MARK Touch

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        let location = touch.location(in: self.tileLayer)
        touchTheMap(location)
    }
    
    private func removeSprite(_ jarron: Jarron){
        jarronLayer.childNode(withName: jarron.spriteName)?.removeFromParent()
    }
    
    private func addSprite(_ jarron: Jarron){
        if let sprite = jarron.sprite {
            sprite.name = jarron.spriteName
            sprite.position = pointFor(column: jarron.column, row: jarron.row)
            sprite.size = CGSize(width: TileWidth, height: TileHeight)
            jarronLayer.addChild(sprite)
        }
    }
    
    private func discoverNeighbour(_ jarron:Jarron){
        let col = jarron.column
        let row = jarron.row
        
        for i in max(0, row - 1)...min(numRows - 1, row + 1) {
            for j in max(0, col - 1)...min(numColumns - 1, col + 1){
                let neighbour = level.jarronAt(column: j, row: i)!
                if neighbour.content == .zero && !neighbour.broken {
                    changeSprite(neighbour)
                    discoverNeighbour(neighbour)
                }
            }
        }
    }
    
    private func discoverAllBomb(){
        for bombs in bombSet{
            changeSprite(bombs)
        }
    }
    
    private func changeSprite(_ jarron: Jarron){
        if !jarron.broken {
            jarron.broken = true
            removeSprite(jarron)
            addSprite(jarron)
            let content = jarron.content
            switch content {
            case .bomb:
                discoverAllBomb()
            case .zero:
                discoverNeighbour(jarron)
            default:
                break
            }
        }
    }
    
    func touchTheMap(_ location:CGPoint)
    {
        let x = location.x
        let y = location.y
        if x > 0 && x < TileWidth * CGFloat(numColumns) &&
        y > 0 && y < TileHeight * CGFloat(numRows){
            let col = Int(y / TileHeight)
            let row = Int(x / TileWidth)
            let jarron = level.jarronAt(column: col, row: row)!
            changeSprite(jarron)
        }
    }
}

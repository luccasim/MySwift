//
//  Level.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

let numColumns = 10
let numRows = 10
let numBomb = 15

class Level {
    fileprivate var jarrons = Array2D<Jarron>(columns: numColumns, rows: numRows)
    fileprivate var tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
    
    func jarronAt(column: Int, row:Int) -> Jarron?{
        return jarrons[column, row]
    }
    
    private func evaluateBombe(jarron: Jarron){
        let col = jarron.column
        let row = jarron.row
        
        for i in max(0, row - 1)...min(numRows - 1, row + 1) {
            for j in max(0, col - 1)...min(numColumns - 1, col + 1){
                let neighbour = jarronAt(column: j, row: i)!
                neighbour.upgrade()
            }
        }
    }
    
    private func shuffleBomb(jarrons: Set<Jarron>)
    {
        var cpy = jarrons
        var bombs = [Jarron]()
        for _ in 0..<numBomb {
            if let bomb = cpy.popFirst() {
                bomb.content = .bomb
                bombs.append(bomb)
            }
        }
        for elem in bombs {
            evaluateBombe(jarron: elem)
        }
    }
    
    func shuffle()-> Set<Jarron> {
        let set = createJarron()
        shuffleBomb(jarrons: set)
        return set
    }
    
    private func createJarron() -> Set<Jarron> {
        var set = Set<Jarron>()
        
        for row in 0..<numRows {
            for col in 0..<numColumns{
                let jarron = Jarron(Row: row, Column: col)
                let tile = Tile()
                tiles[col, row] = tile
                jarrons[col, row] = jarron
                set.insert(jarron)
            }
        }
        return set
    }
}

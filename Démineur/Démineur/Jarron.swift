//
//  Jarron.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation
import SpriteKit

enum JarronContent : Int, CustomStringConvertible {
    case zero = 0, un, deux, trois, quatre, cinq, six, sept, huit, bomb
    
    var name : String {
        let contents = [
            "zero",
            "un",
            "deux",
            "trois",
            "quatre",
            "cinq",
            "six",
            "sept",
            "huit",
            "bombe"
        ]
        return contents[rawValue]
    }
    
    var description: String{
        return name
    }
}

class Jarron {
    
    let row : Int
    let column : Int
    var broken = false
    var content = JarronContent.zero
    
    var spriteName : String {
        return String(hashValue)
    }
    
    var sprite : SKSpriteNode? {
        if !broken {
            return SKSpriteNode(imageNamed: "jarron")
        }
        if content != .zero {
            return SKSpriteNode(imageNamed: content.name)
        }
        return nil
    }
    
    init(Row row:Int, Column col:Int)
    {
        self.row = row
        self.column = col
    }
    
    func upgrade(){
        let i = content.rawValue + 1
        if i < 8 {
            content = JarronContent(rawValue: i)!
        }
    }
}

extension Jarron : Hashable {
    
    var hashValue: Int {
        return row * 10 + column
    }
    
    static func ==(lhs: Jarron, rhs: Jarron) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}

extension Jarron : CustomStringConvertible {
    var description: String {
        let isBroken = (broken) ? "broken" : "not broken"
        return "This jar [\(row),\(column)] is \(isBroken) and content: \(content)"
    }
}

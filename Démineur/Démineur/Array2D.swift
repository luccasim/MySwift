//
//  Array2D.swift
//  Démineur
//
//  Created by luc Casimir on 19/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

class Array2D<T> {
    let columns : Int
    let rows : Int
    fileprivate var array : Array<T?>
    
    init(columns: Int, rows: Int)
    {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}

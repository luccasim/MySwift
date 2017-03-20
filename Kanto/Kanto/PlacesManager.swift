//
//  PlacesManager.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

class PlacesManager {
    private var data = [Place]()
    
    public var count : Int {
        return data.count
    }
    
    public var getData : [Place]{
        return data
    }
    
    init() {
        self.data.append(Place(name: "42"))
        self.data.append(Place(name: "Grenoble"))
        self.data.append(Place(name: "Nice"))
    }
    
    subscript (index:Int) -> Place{
        get {
            return data[index]
        }
        set{
            data.insert(newValue, at: index)
        }
    }
}

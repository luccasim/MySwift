//
//  PersistencyVictim.swift
//  DeathNote
//
//  Created by luc Casimir on 13/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

class PersistencyVictim {
    var data = [Victim]()
    
    var count : Int {
        return data.count
    }
    
    init()
    {
        data.append(Victim(Name: "Toto"))
        data.append(Victim(Name: "Francois Fillon"))
        data.append(Victim(Name: "Donald Trump"))
    }
    
    
    func addVictim(_ victim:Victim)
    {
        data.append(victim)
    }
    
    subscript (_ index:Int) -> Victim{
        get {
            return data[index]
        }
    }
}

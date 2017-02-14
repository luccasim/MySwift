//
//  Victim.swift
//  DeathNote
//
//  Created by luc Casimir on 13/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class Victim {
    var name : String
    var date : Date?
    var details : String?
    
    var getDetails : String {
        get {
            return details ?? "Killed by :\nHeart Attack!"
        }
    }
    
    var getDate: String {
        get {
            let format = DateFormatter()
            format.setLocalizedDateFormatFromTemplate("dd/MM/YY 'at' HH:mm:ss")
            let newDate = date ?? Date(timeIntervalSinceNow: 60 * 15)
            return format.string(from: newDate)
        }
    }
    
    init(Name name:String, Date date:Date?, Details details:String?){
        self.name = name
        self.date = date
        self.details = details
    }
    
    convenience init(Name name:String)
    {
        self.init(Name: name, Date: nil, Details: nil)
    }
}

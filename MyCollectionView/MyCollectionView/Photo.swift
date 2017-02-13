//
//  Photo.swift
//  MyCollectionView
//
//  Created by luc Casimir on 10/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var url : URL
    var img : UIImage?
    
    init(_ url: URL)
    {
        self.url = url
    }
    
    convenience init(withString str:String)
    {
        if let newURL = URL.init(string: str){
            self.init(newURL)
        }
        else{
            self.init(URL(string: "error")!)
            self.img = #imageLiteral(resourceName: "error")
        }
    }
}

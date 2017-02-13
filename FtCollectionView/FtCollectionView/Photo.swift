//
//  Photo.swift
//  FtCollectionView
//
//  Created by luc Casimir on 08/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class Photo: NSObject
{
    var image : UIImage?
    var url : URL?
    var name : String
    
    var getImage : UIImage {
        get {
            let ret = image ?? #imageLiteral(resourceName: "error")
            return ret
        }
    }
    
    init(Name name: String, Image image: UIImage?, URL url: URL?)
    {
        self.name = name
        self.image = image
        self.url = url
    }
    
    convenience init(Name name: String, Url url: URL?)
    {
        self.init(Name: name, Image: nil, URL: url)
    }
    
    convenience init(Name name: String, WithImage image:UIImage)
    {
        self.init(Name:name, Image: image, URL: nil)
    }
}

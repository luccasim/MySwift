//
//  PersistencyPhoto.swift
//  MyCollectionView
//
//  Created by luc Casimir on 10/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class PersistencyPhoto: NSObject {
    
    private var data = [Photo]()
    
    var count : Int {
        get {
            return data.count
        }
    }
 
    override init() {
        super.init()
        data.append(Photo.init(withString: "http://all4desktop.com/data_images/original/4149951-mount-pilatus.jpg"))
        data.append(Photo.init(withString: "http://www.hdwallpapers.in/walls/anno_2205_4k_8k-wide.jpg"))
        data.append(Photo.init(withString: "http://www.hdwallpapers.in/walls/ark_scorched_earth_4k_8k-wide.jpg"))
        data.append(Photo.init(withString: "error" + "http://gameranx.com/wp-content/uploads/2016/03/The-Legend-of-Zelda-Twilight-Princess-HD-4K-Wallpaper-2.jpg"))
//        data.append(Photo(withString: "This is not a url!"))
    }
    
    private func range(index:Int) -> Bool {
        return 0 <=  index && count >= index
    }
    
    func clearPhoto()
    {
        data.removeAll()
    }
    
    func addPhoto(_ photo:Photo)
    {
        data.append(photo)
    }
    
    subscript(index:Int) -> Photo
    {
        get
        {   if range(index: index){
                return data[index]
            }
            return data.first!
        }
    }
}

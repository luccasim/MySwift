//
//  Playlist.swift
//  Deezer
//
//  Created by luc Casimir on 17/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class Playlist {
    var imageUrl : URL!
    var title : String!
    var nbTracks : Int!
    var creationDate : Date!
    var creatorName : String!
    var image : UIImage?
    
    init(ImageUrl imageUrl:String, Title title:String, NbTrack nbTracks:Int, CreationDate creationDate:String, CreatorName creatorName:String)
    {
        if let urlImage = URL(string: imageUrl){
            self.imageUrl = urlImage
        }
        let formatDate = DateFormatter()
        formatDate.dateFormat = "YYYY-dd-MM HH:mm:ss"
        if let dateCreation = formatDate.date(from: creationDate){
            self.creationDate = dateCreation
        }
        self.title = title
        self.nbTracks = nbTracks
        self.creatorName = creatorName
    }
}

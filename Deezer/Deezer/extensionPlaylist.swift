//
//  extensionPlaylist.swift
//  Deezer
//
//  Created by luc Casimir on 19/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

extension Playlist : CustomStringConvertible {
    var cellTitle : String {
        return title
    }
    
    var cellNbTracks : String {
        return nbTracks.description
    }
    
    var cellDate : String {
        let format = DateFormatter()
        format.dateFormat = "[dd-MM-YYYY]"
        return format.string(from: creationDate)
    }
    
    var cellOwnerName : String {
        return creatorName
    }
    
    var cellUrl : String {
        return imageUrl.absoluteString
    }
    
    var description: String {
        return "Titre : \(cellTitle)\n" +
                "nb tracks : \(cellNbTracks)\n" +
                "creation date : \(cellDate)\n" +
                "From : \(cellOwnerName)\n" +
                "Url : \(cellUrl)\n"
    }
}

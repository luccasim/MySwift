//
//  PlaylistManager.swift
//  Deezer
//
//  Created by luc Casimir on 17/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

class PlaylistManager {
    private var data = [Playlist]()
    
    func addPlaylist(Playlist playlist:Playlist)
    {
        data.append(playlist)
    }
    
    func getPlaylists() -> [Playlist]
    {
        return data
    }
    
    subscript(index: Int) -> Playlist{
        get{
            return data[index]
        }
        set{
            data.insert(newValue, at: index)
        }
    }
}

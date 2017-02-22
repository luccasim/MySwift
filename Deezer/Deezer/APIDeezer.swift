//
//  APIDeezer.swift
//  Deezer
//
//  Created by luc Casimir on 17/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

protocol APIDeezerDelegate {
    func startApp(_ apiDeezer: APIDeezer, Data data:[Playlist])
}

class APIDeezer {
    var delegate : APIDeezerDelegate?
    private let code : String
    private let playlist = PlaylistManager()
    
    init(Delegate delegate:APIDeezerDelegate, Code code:String)
    {
        self.code = code
        self.delegate = delegate
        self.getUserPlaylistID()
    }

    func getPlaylist() -> [Playlist]
    {
        return self.playlist.getPlaylists()
    }
    
    private func foo()
    {
        self.compteur += 1
        if self.compteur >= self.nbPlaylist {
            self.delegate?.startApp(self, Data: getPlaylist())
        }
    }

    private var nbPlaylist = 0
    private var compteur = 0
    
    private func getPlaylist(_ playlists: [String]){
        for elem in playlists {
            if let url = URL(string :"http://api.deezer.com/playlist/\(elem)?access_token=\(code)") {
                var request = URLRequest(url:url)
                request.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: request){
                    data, response, error in
                    if let d = data {
                        do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            let creation_date = json["creation_date"] as? String ?? ""
                            let title = json["title"] as? String ?? ""
                            let picture = json["picture"] as? String ?? ""
                            let nb_track = json["nb_tracks"] as? Int ?? 0
                            var creatorName = ""
                            if let creator = json["creator"] as? NSDictionary {
                                    creatorName = creator["name"] as? String ?? "Error"
                            }
                            let newPlaylist = Playlist(ImageUrl: picture, Title: title, NbTrack: nb_track, CreationDate: creation_date, CreatorName: creatorName)
                            self.playlist.addPlaylist(Playlist: newPlaylist)
                            DispatchQueue.main.async {self.foo()}
                            }
                        }
                        catch let err {
                            print(err)
                        }
                    }
                }
                task.resume()
            }
        }
    }

    private func getUserPlaylistID()
    {
        if let url = URL(string: "https://api.deezer.com/user/me/playlists?access_token=\(code)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let d = data {
                    var playlistID = [String]()
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                            if let playlists = json["data"] as? [NSDictionary] {
                                for elem in playlists
                                {
                                    if let id = elem["id"] as? Int {
                                        playlistID.append(String(id))
                                    }
                                    if let nb = elem["total"] as? Int {
                                            self.nbPlaylist = nb
                                    }
                                }
                            }
                        }
                    }
                    catch let err {
                        print(err)
                    }
                    self.getPlaylist(playlistID)
//                    DispatchQueue.main.sync {self.delegate?.startApp(self, Data: self.getPlaylist())}
                }
            }
            task.resume()
        }
    }
}

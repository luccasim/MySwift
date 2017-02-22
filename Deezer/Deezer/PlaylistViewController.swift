//
//  PlaylistViewController.swift
//  Deezer
//
//  Created by luc Casimir on 19/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
 
    var apiDeezer : APIDeezer!
    
    func setup()
    {
        apiDeezer.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "PlaylistCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension PlaylistViewController : APIDeezerDelegate {
    func startApp(_ apiDeezer: APIDeezer, Data data: [Playlist]) {
        collectionView.reloadData()
    }
}

extension PlaylistViewController : UICollectionViewDelegate {
    
}

extension PlaylistViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiDeezer.getPlaylist().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as? PlaylistCell
        cell?.setup(withPlaylist: apiDeezer.getPlaylist()[indexPath.row])
        return cell!
    }
}

extension PlaylistViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 200)
    }
}

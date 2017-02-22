//
//  PlaylistCell.swift
//  Deezer
//
//  Created by luc Casimir on 17/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class PlaylistCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberTrackLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var dateLabe: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!

    func setup(withPlaylist pl:Playlist)
    {
        titleLabel.text = pl.cellTitle
        numberTrackLabel.text = pl.cellNbTracks
        dateLabe.text = pl.cellDate
        ownerLabel.text = pl.cellOwnerName
        albumImageView.image = #imageLiteral(resourceName: "deezer")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

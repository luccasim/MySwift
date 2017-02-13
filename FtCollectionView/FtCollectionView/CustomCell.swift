//
//  CustomCell.swift
//  FtCollectionView
//
//  Created by luc Casimir on 08/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    func setup(WithPhoto photo: Photo)
    {
        imageView.image = photo.getImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

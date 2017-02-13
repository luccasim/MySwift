//
//  PhotoCell.swift
//  MyCollectionView
//
//  Created by luc Casimir on 10/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate {
    func PhotoCellError(_ message: String)
}

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!{
        didSet{
            activityMonitor.hidesWhenStopped = true
            activityMonitor.stopAnimating()
        }
    }
    
    var delegate : PhotoCellDelegate?
    var allowDetail : Bool = false

    private func loadImageFromUrl(_ photo: Photo)
    {
        activityMonitor.startAnimating()
        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)
        
        queue.async {
            if let result = try? Data(contentsOf: photo.url){
                if let img = UIImage(data: result){
                    photo.img = img
                    DispatchQueue.main.async {
                        self.imageView.image = img
                        self.textLabel.text = photo.url.absoluteString
                        self.activityMonitor.stopAnimating()
                        self.allowDetail = true
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    self.delegate?.PhotoCellError(photo.url.absoluteString)
                    self.textLabel.text = "Error"
                    self.activityMonitor.stopAnimating()
                }
            }
        }
    }
    
    func setup(withPhoto photo:Photo)
    {
        if photo.img != nil {
            allowDetail = true
        }
        else {
            loadImageFromUrl(photo)
        }
    }
}

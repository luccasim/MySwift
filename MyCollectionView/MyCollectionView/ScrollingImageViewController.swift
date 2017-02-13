//
//  ScrollingImageViewController.swift
//  MyCollectionView
//
//  Created by luc Casimir on 10/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class ScrollingImageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    fileprivate var imageView : UIImageView!
    var image : UIImage?
    
    func setup()
    {
        scrollView.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let img = image {
            imageView = UIImageView(image: img)
            scrollView.addSubview(imageView)
            scrollView.contentSize = imageView.frame.size
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension ScrollingImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

//
//  FtCollectionViewController.swift
//  FtCollectionView
//
//  Created by luc Casimir on 08/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class FtCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collection: UICollectionView!
    
    var data = [Photo]()
    
    func setup()
    {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        data.append(Photo(Name: "tigre", WithImage: #imageLiteral(resourceName: "tigre")))
        data.append(Photo(Name: "montagne", WithImage: #imageLiteral(resourceName: "montagne")))
        data.append(Photo(Name: "mer", WithImage: #imageLiteral(resourceName: "mer")))
        data.append(Photo(Name: "goutte", WithImage: #imageLiteral(resourceName: "goutte")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? CustomCell
        cell?.setup(WithPhoto: data[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension FtCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

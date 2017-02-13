//
//  MyCollectionViewController.swift
//  MyCollectionView
//
//  Created by luc Casimir on 10/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var data = PersistencyPhoto()
    
    private func setup()
    {
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.brown
        collectionView.register(UINib.init(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        collectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSegue":
                if let dvc = segue.destination as? ScrollingImageViewController{
                    if let cell = sender as? PhotoCell {
                        dvc.image = cell.imageView.image
                    }
                }
            default:
                break
            }
        }
    }
    
}

extension MyCollectionViewController : PhotoCellDelegate
{
    func PhotoCellError(_ message:String)
    {
        let alert = UIAlertController(title: "Error Download", message: message, preferredStyle: .alert)
        let validButtonAlerte = UIAlertAction(title: "OK", style: .default)
        {
            (result:UIAlertAction) in
        }
        alert.addAction(validButtonAlerte)
        present(alert, animated: true, completion: nil)
    }

}

extension MyCollectionViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            if cell.allowDetail {
                performSegue(withIdentifier: "showSegue", sender: cell)
            }
        }
    }
}

extension MyCollectionViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? PhotoCell
        cell?.delegate = self
        cell?.setup(withPhoto: data[indexPath.row])
        return cell!
    }
}

extension MyCollectionViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

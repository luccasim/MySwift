//
//  ProfileViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!

    fileprivate var user : User = api42.shared.currentUser!
    
    private func getImage(){
        if let img = user.image {
            self.imageView.image = img
        }
        else {
            if let url = URL(string: user.profile.imageUrl) {
                let qos = DispatchQoS.background.qosClass
                let queue = DispatchQueue.global(qos: qos)
                queue.async {
                    if let data = try? Data.init(contentsOf: url){
                        let img = UIImage.init(data: data)
                        DispatchQueue.main.async {
                            self.user.image = img
                            self.imageView.image = img
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

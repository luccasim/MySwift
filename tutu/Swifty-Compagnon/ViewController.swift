//
//  ViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/27/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var api = api42.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        api.loginRequest(Login: "fsylla")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


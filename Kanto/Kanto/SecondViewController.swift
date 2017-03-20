//
//  SecondViewController.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    fileprivate var data = PlacesManager()
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "placeCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SecondViewController : UITableViewDelegate{
    
}

extension SecondViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell") as? PlaceCell
        cell?.setup(WithPlace: data[indexPath.row])
        return cell!
    }
}

//
//  ViewController.swift
//  DeathNote
//
//  Created by luc Casimir on 13/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class DeathNoteController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = PersistencyVictim()
    
    func setup()
    {
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "VictimCell", bundle: nil), forCellReuseIdentifier: "myCell")
        tableView.dataSource = self
        tableView.backgroundView = UIImageView.init(image: #imageLiteral(resourceName: "images-4"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue, sender:Any?) {
        tableView.reloadData()
    }
}

extension DeathNoteController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension DeathNoteController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? VictimCell
        cell?.setup(withVictim: data[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

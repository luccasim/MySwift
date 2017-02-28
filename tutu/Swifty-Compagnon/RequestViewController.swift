//
//  RequestViewController.swift
//  Swifty-Compagnon
//
//  Created by Luc CASIMIR on 2/28/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.delegate = self
            textField.autocorrectionType = .no
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate var api = api42.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        if api.getUsers().count == 0 {
            self.tableView.isHidden = true
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var dvc = segue.destination
//        if let tabcon = dvc as? UITabBarController{
//            dvc = (tabcon.viewControllers?[1])!
//        }
//        if let identifier = segue.identifier,
//            let dest = dvc as? ProfileViewController,
//            let user = sender as? User{
//            switch identifier {
//            case "user":
//                dest.data = user.profile
//            default:
//                break
//            }
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.isHidden = false
        if api.getUsers().count == 0 {
            tableView.isHidden = true
        }
        tableView.reloadData()
    }
}

extension RequestViewController : Api42Delegate {
    func userHandle(User user: User) {
        performSegue(withIdentifier: "user", sender: user)
    }
}

extension RequestViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = api.getUsers()[indexPath.row]
        api.currentUser = user
        performSegue(withIdentifier: "user", sender: user)
    }
}

extension RequestViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.getUsers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loginCell")
        cell?.textLabel?.text = api.getUsers()[indexPath.row].profile.login
        return cell!
    }
}

extension RequestViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let login = textField.text!
        api.loginRequest(Login: login)
        return textField.resignFirstResponder()
    }
}

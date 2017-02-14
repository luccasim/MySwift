//
//  NewVictimViewController.swift
//  DeathNote
//
//  Created by luc Casimir on 13/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class NewVictimViewController: UIViewController {

    fileprivate var newVictim : Victim!
    fileprivate var allowToKill = false {
        didSet {
            if allowToKill {
                turnHidden(false)
                killButton.titleLabel?.text = "Valid to kill : " + (textField?.text)!
            }
        }
    }
    
    @IBOutlet weak var killButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    
    private func turnHidden(_ setHidden: Bool)
    {
        killButton.isHidden = setHidden
        datePicker.isHidden = setHidden
        textView.isHidden = setHidden
    }
    
    func setup(){
        turnHidden(true)
        self.view.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "images-3"))
        textField.delegate = self
        textView.delegate = self
        datePicker.date = Date(timeIntervalSinceNow: 60 * 15)
        textView?.text = "Killed by:\nHeart attack!"
        textView.backgroundColor = UIColor.clear
    }
    
    @IBAction func killAction() {
        if allowToKill {
            performSegue(withIdentifier: "unwind", sender: nil)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "unwind":
                if let dvc = segue.destination as? DeathNoteController {
                    newVictim.date = datePicker.date
                    newVictim.details = textView.text
                    dvc.data.addVictim(newVictim)
                }
            default:
                break
            }
        }
    }
}

extension NewVictimViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newVictim = Victim(Name: textField.text!)
        allowToKill = true
        return textField.resignFirstResponder()
    }
}

extension NewVictimViewController : UITextViewDelegate {
}

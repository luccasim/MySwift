//
//  ViewController.swift
//  Calculator
//
//  Created by luc Casimir on 28/01/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet var digitButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    var userIsInTheMiddleOfTapping = false
    var theNumberIsNegative = false
    var brain = Calculator()
    
    private func setColor()
    {
        for elem in digitButtons{
            elem.backgroundColor = UIColor.lightGray
        }
        for elem in operatorButtons{
            elem.backgroundColor = UIColor.orange
        }
        display.backgroundColor = UIColor.darkGray
    }
    
    override func viewDidLoad() {
        setColor()
    }
    
    var saveProgram : Calculator.PropertyList?
    
    @IBAction func saveButton() {
        saveProgram = brain.program
    }
    
    @IBAction func restoreButton() {
        if saveProgram != nil{
            brain.program = saveProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction func digitButtonTouched(_ sender: UIButton)
    {
        
        let digit = sender.currentTitle!
        let currentDisplayText = display.text!
        
        if userIsInTheMiddleOfTapping
        {
            display.text = currentDisplayText + digit
        }
        else
        {
            display.text = digit
        }
        userIsInTheMiddleOfTapping = true
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperator(_ sender: UIButton) {
        if userIsInTheMiddleOfTapping {
            brain.setOperator(operand: displayValue)
        }
        userIsInTheMiddleOfTapping = false
        if let symbols = sender.currentTitle {
            brain.performOperator(symbols)
        }
        displayValue = brain.result
    }

}


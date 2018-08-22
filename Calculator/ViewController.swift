//
//  ViewController.swift
//  Calculator
//
//  Created by JunHyuk on 2017. 7. 20..
//  Copyright © 2017년 JunHyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel! //weak - Strong : weak
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }set {
            display.text = String(newValue)
        }
    }
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program        //계산된 값을 저장.
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!   //저장된 값을 다시 불러오는 버튼기능
            displayValue = brain.result
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
            }
         displayValue = brain.result
    }
}

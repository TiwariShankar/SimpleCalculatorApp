//
//  ViewController.swift
//  SimpleCalculatorApp
//
//  Created by Shanky on 9/19/15.
//  Copyright © 2015 Shanky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userinmiddleofwriting :Bool = false
    var brain = CalBrain()
   
    @IBAction func digitPressed(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if(userinmiddleofwriting){
            display.text = display.text! + digit
        }else{
            display.text = digit
            userinmiddleofwriting = true
        }
    }
    
    @IBAction func enterPressed() {
        userinmiddleofwriting = false
        if let result = brain.pushOperand(displayVal){
            displayVal = result
        }else{
            displayVal = 0
        }
    }
    
    
    @IBAction func operatorPressed(sender: UIButton) {
       if userinmiddleofwriting{
            enterPressed()
        }
        
        if let caseoperator = sender.currentTitle {
            if let result = brain.performOperation(caseoperator){
                displayVal = result
            }else{
                displayVal = 0
            }
        }
        
        
    }
    

   
    var displayVal : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userinmiddleofwriting = false
        }
    }
}



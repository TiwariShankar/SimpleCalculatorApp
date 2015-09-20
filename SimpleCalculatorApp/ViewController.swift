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
    var arrayStack = Array<Double>();
    
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
        arrayStack.append(displayVal)
       print("\(arrayStack)")
    }
    
    
    @IBAction func operatorPressed(sender: UIButton) {
        let caseoperator = sender.currentTitle!
        if userinmiddleofwriting{
            enterPressed()
        }
        
        switch caseoperator {
            case "+":
                performOperation {$0 + $1}
                break
            
            case "-":
                performOperation {$0 - $1}
                break
            
            case "/":
                performOperation {$0 / $1}
                break
            
            case "*":
                performOperation {$0 * $1}
                break
            
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if arrayStack.count >= 2 {
            displayVal = operation(arrayStack.removeLast(), arrayStack.removeLast())
            enterPressed()
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



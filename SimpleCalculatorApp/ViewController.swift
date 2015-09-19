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
    
    @IBAction func keypressed(sender: UIButton) {
    
        let digit = sender.currentTitle!
       
        if(userinmiddleofwriting){
            display.text = display.text! + digit
        }else{
            display.text = digit
            userinmiddleofwriting = true
        }
    }
    
    
}


//
//  ViewController.swift
//  Calculate
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var nums = [Double]()
    var operateStack = [String]()
    var operate = ""
    var isOperate = true
    var sum = 0.0
    let brain = CalculateModel()
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(numLabel.text!)!.doubleValue
        }
        
        set {
            numLabel.text = "\(newValue)"
        }
    }
    
    @IBAction func numButtonDidTouch(sender: UIButton) {
        let num = sender.currentTitle!
        let value = Double(num)!
        sum = sum * 10 + value
        displayValue = sum
        
        brain.pushOperand(sum)
        
        isOperate = false
    }
    
    @IBAction func operateButtonDidTouch(sender: UIButton) {
        
        if isOperate {
            operate = sender.currentTitle!
            brain.performOPeration(operate)
            print("A little more tapped operate button...")
            print("Current Operate: \(operate)")
            return
        }
        
        isOperate = true
        nums.append(sum)
        sum = 0.0
        
//        switch operate {
//        case "+":
//            performOperate { $0 + $1 }
//            break
//            
//        case "−":
//            performOperate { $0 - $1 }
//            break
//            
//        case "×":
//            performOperate { $0 * $1 }
//            break
//            
//        case "÷":
//            performOperate { $1 / $0 }
//            break
//            
//        case "√":
//            performOperate { sqrt($0) }
//            break
//            
//        case "=":
//            performOperate { $0 }
//            break
//            
//        default:
//            break
//        }
//        print("\(nums)")
        if let result = brain.evaluate() {
            displayValue = result
        }
        
        operate = sender.currentTitle!
        brain.performOPeration(operate)
    }
    
//    func performOperate(operation: (Double, Double) -> (Double)) {
//        if  nums.count >= 2 {
//            displayValue = operation(nums.removeLast(), nums.removeLast())
//            nums.append(displayValue)
//        }
//    }
//    
//    private func performOperate(operation: Double -> Double) {
//        if  nums.count >= 1 {
//            displayValue = operation(nums.removeLast())
//            nums.append(displayValue)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


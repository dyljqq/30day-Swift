//
//  ViewController.swift
//  EmojiMachine
//
//  Created by 季勤强 on 16/6/3.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var emojiPickView: UIPickerView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
    
    var nums = [[Int]]()
    var bounds = CGRectZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (var i = 0; i < 100; i++){
            var num = [Int]()
            for (var j = 0; j < 3; j++){
                num.append((Int)(arc4random() % 10))
            }
            nums.append(num)
        }
        
        bounds = goButton.bounds
        resultLabel.text = ""
        
        emojiPickView.delegate = self
        emojiPickView.dataSource = self;
        
        goButton.layer.cornerRadius = 6
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            
            self.goButton.alpha = 0
            
            }, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            
            self.goButton.alpha = 1
            
            }, completion: nil)
    }
    
    //MARK: - Delegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return nums[0].count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nums.count
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let index = (Int)(nums[row][component])
        pickerLabel.text = imageArray[index]
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    //MARK: - Action
    
    @IBAction func goButtonDidTouch(sender: AnyObject) {
        
        self.goButton.enabled = false
        
        for (var i = 0; i < 3; i++){
            emojiPickView.selectRow((Int)(arc4random()) % 90 + 3, inComponent: i, animated: true)
        }
        
        if ( nums[emojiPickView.selectedRowInComponent(0)][0] ==  nums[emojiPickView.selectedRowInComponent(1)][1] && nums[emojiPickView.selectedRowInComponent(1)][1] == nums[emojiPickView.selectedRowInComponent(2)][2]) {
            resultLabel.text = "Bingo"
        }else{
            resultLabel.text = "💔"
        }
        
        //animate
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .CurveLinear, animations: {
            
            self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width + 20, height: self.bounds.size.height)
            
            }, completion: { (compelete: Bool) in
                
                UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: {
                    
                    self.goButton.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
                    self.goButton.enabled = true
                    
                    }, completion: nil)
                
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


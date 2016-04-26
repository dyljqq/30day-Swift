//
//  ViewController.swift
//  StopWatch
//
//  Created by 季勤强 on 16/4/26.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = NSTimer()
    var count = 0.0
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = String(count)
    }
    
    
    @IBAction func resetButtonDidTouch(sender: AnyObject) {
        isPlaying = false
        timeLabel.text = "0"
        timer.invalidate()
        count = 0
        playBtn.enabled = true
        pauseBtn.enabled = true
    }

    @IBAction func playButtonDidTouch(sender: AnyObject) {
        if isPlaying {
            return
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
        playBtn.enabled = false
        pauseBtn.enabled = true
        isPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(sender: AnyObject) {
        timer.invalidate()
        playBtn.enabled = true
        pauseBtn.enabled = true
        isPlaying = false
    }
    
    func UpdateTimer() {
        count = count + 0.1
        timeLabel.text = String(format: "%.1f", arguments: [count])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


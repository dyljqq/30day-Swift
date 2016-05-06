//
//  ViewController.swift
//  RandomColorization
//
//  Created by 季勤强 on 16/5/3.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    @IBAction func playMusicButtonDidTouch(sender: AnyObject) {
        let bgMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Ecstasy", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOfURL: bgMusic)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch let audioError as NSError {
            print(audioError)
        }
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "randomColor", userInfo: nil, repeats: true)
        changeBackgroundViewColor()
        
        gradient.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).CGColor as CGColorRef
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).CGColor as CGColorRef
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).CGColor as CGColorRef
        let color5 = UIColor(white: 0.4, alpha: 0.2).CGColor as CGColorRef
        gradient.colors = [color1, color2, color3, color4, color5]
        gradient.locations = [0.1, 0.3, 0.5, 0.7, 0.9]
        gradient.startPoint = CGPointMake(0, 0)
        gradient.endPoint = CGPointMake(1, 1)
        self.view.layer.addSublayer(gradient)
    }
    
    //change view's background color, and color is random
    func changeBackgroundViewColor(){
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    func randomColor() {
        changeBackgroundViewColor()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


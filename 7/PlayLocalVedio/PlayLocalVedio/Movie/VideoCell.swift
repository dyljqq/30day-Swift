//
//  VideoCell.swift
//  PlayLocalVedio
//
//  Created by 季勤强 on 16/4/27.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

struct video {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoScreenshot: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    let playViewController = AVPlayerViewController()
    
    @IBAction func playVideoButtonDidTouch(sender: AnyObject) {
        guard let path = NSBundle.mainBundle().pathForResource("emoji zone", ofType: "mp4") else {
            print("Cann't find this mp4 file")
            return
        }
        let playerView = AVPlayer(URL: NSURL(fileURLWithPath: path))
        playViewController.player = playerView
        presentViewController()
    }
    
}

extension UITableViewCell {
    func getCurrentViewController()-> UIViewController? {
        let window = UIApplication.sharedApplication().keyWindow
        let navigationController = window?.rootViewController
        if navigationController is UINavigationController {
            let navigation = navigationController as! UINavigationController
            return navigation.topViewController!
        }
        return nil
    }
}

extension VideoCell {
    func presentViewController() {
        let currentController = getCurrentViewController()
        currentController?.presentViewController(self.playViewController, animated: true, completion: {
            self.playViewController.player?.play()
        })
    }
}

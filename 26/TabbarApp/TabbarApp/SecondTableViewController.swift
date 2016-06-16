//
//  SecondTableViewController.swift
//  TabbarApp
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class SecondTableViewController: UIViewController {
    
    @IBOutlet weak var exploreImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        exploreImageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        exploreImageView.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
            self.exploreImageView.transform = CGAffineTransformIdentity
            self.exploreImageView.alpha = 1
            }, completion: nil)
    }
    
}

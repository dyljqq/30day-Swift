//
//  ThirdViewController.swift
//  TabbarApp
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var readLaterImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readLaterImageView.alpha = 0
        self.readLaterImageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
            self.readLaterImageView.alpha = 1
            self.readLaterImageView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
}

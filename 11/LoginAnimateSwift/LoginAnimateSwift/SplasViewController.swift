//
//  SplasViewController.swift
//  LoginAnimateSwift
//
//  Created by 季勤强 on 16/5/31.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class SplasViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

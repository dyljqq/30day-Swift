//
//  ViewController.swift
//  BasicAnimation
//
//  Created by 季勤强 on 16/6/14.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


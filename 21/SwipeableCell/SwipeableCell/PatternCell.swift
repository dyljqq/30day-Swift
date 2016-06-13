//
//  PatternCell.swift
//  SwipeableCell
//
//  Created by 季勤强 on 16/6/13.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

struct pattern {
    let image: String
    let name: String
}

class PatternCell: UITableViewCell {
    
    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var patternNameLabel: UILabel!
    
    
    
}

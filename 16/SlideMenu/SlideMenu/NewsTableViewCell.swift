//
//  NewsTableViewCell.swift
//  SlideMenu
//
//  Created by 季勤强 on 16/6/6.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorImageView.layer.cornerRadius = authorImageView.frame.size.width / 2
        authorImageView.layer.masksToBounds = true
    }
    
}

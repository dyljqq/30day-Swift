//
//  ArticalTableViewCell.swift
//  TabbarApp
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

//struct artical {
//    let avatarImage: String
//    let avatarName: String
//    let actionType: String
//    let articalCoverImage: String
//    let articalContent: String
//    let articalSource: String
//    let articalTime: String
//}

struct article {
    let avatarImage: String
    let sharedName: String
    let actionType: String
    let articleTitle: String
    let articleCoverImage: String
    let articleSouce: String
    let articleTime: String
}

class ArticalTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarName: UILabel!
    @IBOutlet weak var actionTypeLabel: UILabel!
    @IBOutlet weak var articalCoverImageView: UIImageView!
    @IBOutlet weak var articalContentLabel: UILabel!
    @IBOutlet weak var articalSourceLabel: UILabel!
    @IBOutlet weak var articalTimeLabel: UILabel!
    
}

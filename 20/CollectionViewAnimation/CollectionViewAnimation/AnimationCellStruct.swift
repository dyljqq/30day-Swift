//
//  AnimationCellModel.swift
//  CollectionViewAnimation
//
//  Created by 季勤强 on 16/6/12.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

struct AnimationCellModel {
    
    let imagePath: String
    
    init(imagePath: String) {
        self.imagePath = imagePath
    }
    
}

struct AnimationImageCollectionModel {
    private let imagePaths = ["1", "2", "3", "4", "5"]
    var images: [AnimationCellModel]
    
    init() {
        images = imagePaths.map({ path in AnimationCellModel(imagePath: path) })
    }
}
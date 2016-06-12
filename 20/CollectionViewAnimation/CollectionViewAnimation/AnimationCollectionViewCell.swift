//
//  AnimationCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by 季勤强 on 16/6/12.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var animationTextView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    var backButtonTapped: ( () -> Void)?
    
    func initCell(viewModel: AnimationCellModel) {
        animationImageView.image = UIImage(named: viewModel.imagePath)
        animationTextView.scrollEnabled = false
        backButton.hidden = true
        backButton.addTarget(self, action: "backButtonDidTouch:", forControlEvents: .TouchUpInside)
    }
    
    func handleCellSelected() {
        animationTextView.scrollEnabled = true
        backButton.hidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    //MARK: - Action
    
    func backButtonDidTouch(sender: UIGestureRecognizer) {
        backButtonTapped?()
    }
    
}

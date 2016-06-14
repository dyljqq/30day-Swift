//
//  PositionViewController.swift
//  BasicAnimation
//
//  Created by 季勤强 on 16/6/14.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import SnapKit

class PositionViewController: UIViewController {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var mouseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Position"
        
        animate()
    }
    
    //MARK: - Private Method
    
    private func animate() {
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
            
            let centerX = self.view.center.x - self.leftView.center.x
            let centerY = self.leftView.center.y + 30
//            self.leftView.snp_makeConstraints("", closure: { make in
//                make.centerX.equalTo(centerX)
//                make.centerY.equalTo(centerY)
//            })
            
            }, completion: { finished in
                
                UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
                    
                    var frame = self.mouseView.frame
                    frame.size.height = 180
                    self.mouseView.frame = frame
                    self.mouseView.center.y += 20
                    
                    }, completion: nil)
                
        })
    }
    
}

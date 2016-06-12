//
//  RefreshView.swift
//  PullRefresh
//
//  Created by 季勤强 on 16/6/7.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class RefreshView: UIView {
    
    private lazy var labels = [UILabel]()
    
    private var currentIndex = 0
    private var currentColorIndex = 0
    
    var isAnimating = false
    var isRefreshing = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWithString(textString: String) {
        if labels.count == 0 {
            initLabelsWithString(textString)
        }
    }
    
    //MARK: - Public Method
    
    func endRefresh() {
        self.isAnimating = false
        self.currentIndex = 0
        for label in self.labels {
            label.textColor = UIColor.blackColor()
            label.transform = CGAffineTransformIdentity
        }
    }
    
    func animateRefresh() {
        isAnimating = true
        
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveLinear, animations: {
            
            self.labels[self.currentIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.labels[self.currentIndex].textColor = self.nextColor()
            
            }, completion: { finished in
                
                UIView.animateWithDuration(0.05, delay: 0, options: .CurveLinear, animations: {
                    
                    self.labels[self.currentIndex].transform = CGAffineTransformIdentity
                    self.labels[self.currentIndex].textColor = UIColor.blackColor()
                    
                    }, completion: { finished in
                        
                        self.currentIndex++
                        if self.currentIndex < self.labels.count {
                            self.animateRefresh()
                        }else {
                            self.animateRefreshScale()
                        }
                        
                    })
                
        })
    }
    
    func animateRefreshScale() {
        
        UIView.animateWithDuration(0.40, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            for label in self.labels {
                label.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
            
            }, completion: { finished in
                
                UIView.animateWithDuration(0.25, delay: 0, options: .CurveLinear, animations: {
                    
                    for label in self.labels {
                        label.transform = CGAffineTransformIdentity
                    }
                    
                    }, completion: { finished in
                        
                        if self.isRefreshing {
                            
                            self.currentIndex = 0
                            self.animateRefresh()
                            
                        }else{
                            
                            self.endRefresh()
                            
                        }
                        
                })
        })
        
    }
    
    //MARK: - Private Method
    
    private func initLabelsWithString(textString: String) {
        
        let length = textString.characters.count;
        let space = 5.0
        let labelWidth = 20.0
        let labelHeight = 30.0
        var x = (Double(self.frame.size.width) - Double(length) * (labelWidth + space)) / 2
        for ch in textString.characters {
            let label = UILabel(frame: CGRectMake(CGFloat(x), 10.0, CGFloat(labelWidth), CGFloat(labelHeight)))
            label.text = "\(ch)"
            label.textColor = UIColor.blackColor()
            label.font = UIFont.systemFontOfSize(20)
            label.textAlignment = NSTextAlignment.Center
            self.addSubview(label)
            
            labels.append(label)
            x += space + labelWidth
        }
    }
    
    func nextColor() -> UIColor {
        
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        currentColorIndex = currentColorIndex % colorsArray.count
        let color = colorsArray[currentColorIndex++]
        
        return color
    }
    
}

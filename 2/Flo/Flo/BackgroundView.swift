//
//  BackgroundView.swift
//  Flo
//
//  Created by 季勤强 on 16/4/12.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

@IBDesignable class BackgroundView: UIView {

    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize: CGFloat = 200
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        CGContextFillRect(context, rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        //insert code here
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0)
        let drawingContext = UIGraphicsGetCurrentContext()
        darkColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x:drawSize.width/2,
            y:0))
        trianglePath.addLineToPoint(CGPoint(x:0,
            y:drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width,
            y:drawSize.height/2))
        
        trianglePath.moveToPoint(CGPoint(x: 0,
            y: drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2,
            y: drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: 0,
            y: drawSize.height))
        
        trianglePath.moveToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height/2))
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2,
            y:drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        //This creates a new UIColor by using an image as a color instead of a solid color.
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }

}

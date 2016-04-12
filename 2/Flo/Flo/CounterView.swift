//
//  CounterView.swift
//  Flo
//
//  Created by 季勤强 on 16/4/8.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {

    @IBInspectable var counter: Int = 5 {
        didSet{
            if counter <= NoOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerGlass: CGFloat = angleDifference / CGFloat(NoOfGlasses)
        let outlineEndAngle: CGFloat = arcLengthPerGlass * CGFloat(counter) + startAngle
        let outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: bounds.width/2 - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        outlinePath.closePath()
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        var markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2, y: 0, width: markerWidth, height: markerSize))
        
        CGContextTranslateCTM(context, rect.width/2, rect.height/2)
        for i in 1 ... NoOfGlasses {
            CGContextSaveGState(context)
            
            var angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            CGContextRotateCTM(context, angle)
            CGContextTranslateCTM(context, 0, rect.height/2 - markerSize)
            markerPath.fill()
            
            CGContextRestoreGState(context)
        }
        CGContextRestoreGState(context)
    }

}

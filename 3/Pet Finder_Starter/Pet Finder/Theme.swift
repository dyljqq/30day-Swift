//
//  Theme.swift
//  Pet Finder
//
//  Created by 季勤强 on 16/4/13.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import UIKit

let SelectedThemeKey = "SelectedThemeKey"

enum Theme: Int{
    case Default, Dark, Graphics
    
    var mainColor:UIColor{
        switch self{
        case .Default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Graphics:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
    
    var barStyle: UIBarStyle {
        switch self{
        case .Default, .Graphics:
            return .Default
        case .Dark:
            return .Black
        }
    }
    
    var navigationBackgroundImage: UIImage? {
        return self == .Graphics ? UIImage(named: "navBackground") : nil
    }
    
    var tabBarBackgroundImage: UIImage?{
        return self == .Graphics ? UIImage(named: "tabBarBackground") : nil
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .Default, .Graphics:
            return UIColor(white: 0.9, alpha: 1.0)
        case .Dark:
            return UIColor(white: 0.8, alpha: 1.0)
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 34.0/255.0, green: 128.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        case .Graphics:
            return UIColor(red: 140.0/255.0, green: 50.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        }
    }
}

struct ThemeManager {
    static func currentTheme() -> Theme {
        if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey(SelectedThemeKey)?.integerValue {
            return Theme(rawValue: storedTheme)!
        }else{
            return .Default
        }
    }
    
    static func applyTheme(theme: Theme) {
        NSUserDefaults.standardUserDefaults().setValue(theme.rawValue, forKey: SelectedThemeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let sharedApplication = UIApplication.sharedApplication()
        //？？表示如果左边为nil，则取右边数据
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, forBarMetrics: .Default)
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        
        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
        
        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.imageWithRenderingMode(.AlwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
        
        let controlBackground = UIImage(named: "controlBackground")?.imageWithRenderingMode(.AlwaysTemplate).resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?.imageWithRenderingMode(.AlwaysTemplate).resizableImageWithCapInsets(UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        UISegmentedControl.appearance().setBackgroundImage(controlBackground, forState: .Normal, barMetrics: .Default)
        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, forState: .Selected, barMetrics: .Default)
        
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, forState: .Highlighted)
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), forState: .Normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), forState: .Normal)
        
        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), forState: .Normal)
        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
            .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)),
            forState: .Normal)
        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
            .imageWithRenderingMode(.AlwaysTemplate)
            .resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)),
            forState: .Normal)
        
        UISwitch.appearance().onTintColor = theme.mainColor.colorWithAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainColor

    }
}
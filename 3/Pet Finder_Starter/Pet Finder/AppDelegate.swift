//
//  AppDelegate.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    print(ThemeManager.currentTheme().mainColor)
    let theme = ThemeManager.currentTheme()
    ThemeManager.applyTheme(theme)
    return true
  }
}


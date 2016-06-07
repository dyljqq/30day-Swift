//
//  MenuTransitionManager.swift
//  TumblrMenu
//
//  Created by 季勤强 on 16/6/7.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var isPresent = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        
        let screens: (from: UIViewController, to: UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = self.isPresent ? screens.to as! MenuViewController : screens.from as! MenuViewController
        let mainViewController = self.isPresent ? screens.from : screens.to 
        
        let menuView = menuViewController.view
        let mainView = mainViewController.view
        
        if isPresent {
            self.offStageMenuController(menuViewController)
        }
        
        container?.addSubview(mainView)
        container?.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresent {
                self.onStageMenuController(menuViewController)
            }else{
                self.offStageMenuController(menuViewController)
            }
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
//                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
                
        })
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    //MARK: - Private Method
    
    func offstage(amount: CGFloat) ->CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuController(menuViewController: MenuViewController) {
        
        menuViewController.view.alpha = 0
        
        let topRowOffset  : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let bottomRowOffset  : CGFloat = 50
        
        menuViewController.textButton.transform = self.offstage(-topRowOffset)
        menuViewController.textLabel.transform = self.offstage(-topRowOffset)
        
        menuViewController.quoteButton.transform = self.offstage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offstage(-middleRowOffset)
        
        menuViewController.chatButton.transform = self.offstage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offstage(-bottomRowOffset)
        
        menuViewController.photoButton.transform = self.offstage(topRowOffset)
        menuViewController.photoLabel.transform = self.offstage(topRowOffset)
        
        menuViewController.linkButton.transform = self.offstage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offstage(middleRowOffset)
        
        menuViewController.audioButton.transform = self.offstage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offstage(bottomRowOffset)
        
    }
    
    func onStageMenuController(menuViewController: MenuViewController) {
        
        
        menuViewController.view.alpha = 1
        
        menuViewController.textButton.transform = CGAffineTransformIdentity
        menuViewController.textLabel.transform = CGAffineTransformIdentity
        menuViewController.quoteButton.transform = CGAffineTransformIdentity
        menuViewController.quoteLabel.transform = CGAffineTransformIdentity
        menuViewController.chatButton.transform = CGAffineTransformIdentity
        menuViewController.chatLabel.transform = CGAffineTransformIdentity
        menuViewController.photoButton.transform = CGAffineTransformIdentity
        menuViewController.photoLabel.transform = CGAffineTransformIdentity
        menuViewController.linkButton.transform = CGAffineTransformIdentity
        menuViewController.linkLabel.transform = CGAffineTransformIdentity
        menuViewController.audioButton.transform = CGAffineTransformIdentity
        menuViewController.audioLabel.transform = CGAffineTransformIdentity
        
    }
    
}

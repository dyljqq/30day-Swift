//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by 季勤强 on 16/6/6.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class MenuTransitionManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresent = false
    var duration = 0.5
    var delegate:MenuTransitionManagerDelegate?
    var snapshot: UIView? {
        
        didSet {
            if let _delegate = delegate {
                let tap = UITapGestureRecognizer(target: _delegate, action: "dismiss")
                snapshot?.addGestureRecognizer(tap)
            }
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        let container = transitionContext.containerView()
        let moveDown = CGAffineTransformMakeTranslation(0, container!.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        
        if isPresent {
            toView?.transform = moveUp
            //获取一个快照
            snapshot = fromView?.snapshotViewAfterScreenUpdates(true)
            container?.addSubview(toView!)
            container?.addSubview(snapshot!)
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: {
            
            if self.isPresent {
                self.snapshot?.transform = moveDown
                toView?.transform = CGAffineTransformIdentity
            }else{
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView?.transform = moveUp
            }
            
            }, completion: { finished in
                transitionContext.completeTransition(true)
                if !self.isPresent {
                    self.snapshot?.removeFromSuperview()
                }
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
    
    
}

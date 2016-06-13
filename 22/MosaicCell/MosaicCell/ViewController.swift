//
//  ViewController.swift
//  MosaicCell
//
//  Created by 季勤强 on 16/6/13.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images = [String]()
    let size = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for(var i = 1; i <= 21; i++){
            images.append(String(i))
        }
        
    }
    
    //MARK: - Delegate
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
        cell.alpha = 0
        
        let imageView = cell.viewWithTag(8888) as! UIImageView
        imageView.image = UIImage(named: images[indexPath.row])
        
        let delay = UInt64((arc4random() % 600) / 1000)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            
            UIView.animateWithDuration(0.8, animations: {
                cell.alpha = 1.0
            })
            
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return indexPath.row % 7 == 0 ? CGSizeMake(size.width - 2, size.width - 2) : CGSizeMake(size.width / 2 - 6, size.width / 2 - 6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


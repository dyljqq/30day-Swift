//
//  AnimationCollectionViewController.swift
//  CollectionViewAnimation
//
//  Created by 季勤强 on 16/6/12.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class AnimationCollectionViewController: UICollectionViewController {
    
    private struct Storyboard {
        static let CellIdentifier = String(AnimationCollectionViewCell)
        static let NibName = String(AnimationCollectionViewCell)
    }
    
    private struct Constants {
        static let AnimationDuration: Double = 0.5
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
    }
    
    var imageCollection: AnimationImageCollectionModel!
    
    //MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollection = AnimationImageCollectionModel()
        let nib: UINib = UINib(nibName: Storyboard.NibName, bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: Storyboard.CellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
    }
    
    //MARK: - Delegate
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! AnimationCollectionViewCell
        let viewModel = imageCollection.images[indexPath.row]
        cell.initCell(viewModel)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.images.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AnimationCollectionViewCell else {
            return
        }
        
        self.handleAnimationCellSelected(collectionView, cell: cell)
    }
    
    //MARK: - Private Method
    
    private func handleAnimationCellSelected(collectionView: UICollectionView, cell: AnimationCollectionViewCell) {
        cell.handleCellSelected()
        cell.backButtonTapped = self.backButtonDidTouch
        
        let animations: () -> () = {
            cell.frame = collectionView.bounds
        }
        
        let completion: (finished: Bool) -> () = { _ in
            collectionView.scrollEnabled = false
        }
        
        UIView.animateWithDuration(Constants.AnimationDuration, delay: Constants.AnimationDelay, usingSpringWithDamping: Constants.AnimationSpringDamping, initialSpringVelocity: Constants.AnimationInitialSpringVelocity, options: [], animations: animations, completion: completion)
        
    }
    
    private func backButtonDidTouch() {
        guard let indexPath = collectionView?.indexPathsForSelectedItems() else {
            return 
        }
        collectionView?.scrollEnabled = true
        collectionView?.reloadItemsAtIndexPaths(indexPath)
    }
    
}

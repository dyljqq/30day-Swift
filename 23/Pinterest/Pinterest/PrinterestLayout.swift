//
//  PrinterestLayout.swift
//  Pinterest
//
//  Created by 季勤强 on 16/6/13.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

protocol PrinterestLayoutDelegate {
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
    withWidth:CGFloat) -> CGFloat
  // 2
  func collectionView(collectionView: UICollectionView,
    heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // 1
  var photoHeight: CGFloat = 0.0
  
  // 2
  override func copyWithZone(zone: NSZone) -> AnyObject {
    let copy = super.copyWithZone(zone) as! PinterestLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  // 3
  override func isEqual(object: AnyObject?) -> Bool {
    if let attributes = object as? PinterestLayoutAttributes {
      if( attributes.photoHeight == photoHeight  ) {
        return super.isEqual(object)
      }
    }
    return false
  }
}

class PrinterestLayout: UICollectionViewLayout {
  
  var delegate: PrinterestLayoutDelegate!
  
  var numberOfColumns = 2
  var cellPadding = 6.0
  
  private var caches = [PinterestLayoutAttributes]()
  private var contentHeight: CGFloat = 0.0
  private var contentWidth: CGFloat {
    let insets = collectionView?.contentInset
    return CGRectGetWidth((collectionView?.bounds)!) - ((insets?.left)! + (insets?.right)!)
  }
  
  override func prepareLayout() {
    if caches.isEmpty {
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
      for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        let width = Double(columnWidth) - cellPadding * 2
        let itemHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: CGFloat(width))
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: CGFloat(width))
        let height = cellPadding + Double(itemHeight) + Double(annotationHeight) + cellPadding
        let frame = CGRectMake(xOffset[column], yOffset[column], CGFloat(width), CGFloat(height))
        let insetFrame = CGRectInset(frame, CGFloat(cellPadding), CGFloat(cellPadding))
        let attributes = PinterestLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.photoHeight = itemHeight
        attributes.frame = insetFrame
        caches.append(attributes)
        
        //CGRectGetMaxY(frame) = y + height
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        yOffset[column] += CGFloat(height)
        
        column = column >= (numberOfColumns - 1) ? 0 : ++column
      }
    }
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSizeMake(contentWidth, contentHeight)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in caches {
      if CGRectIntersectsRect(attributes.frame, rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
  
  //This overrides layoutAttributesClass() to tell the collection view to use PinterestLayoutAttributes whenever it creates layout attributes objects.
  override class func layoutAttributesClass() -> AnyClass {
    return PinterestLayoutAttributes.self
  }
  
}

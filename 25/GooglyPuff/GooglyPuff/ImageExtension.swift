//
//  ImageExtension.swift
//  GooglyPuff
//
//  Created by 季勤强 on 16/6/15.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

extension CGRect {
    mutating func scaleRect(scale: CGFloat) {
        origin.x *= scale
        origin.y *= scale
        size.width *= scale
        size.height *= scale
    }
}

extension UIImage {
    
    func croppedImage(var bounds: CGRect)-> UIImage {
        let scale = max(self.scale, 1.0)
        bounds.scaleRect(scale)
        guard let imageRef = CGImageCreateWithImageInRect(self.CGImage, bounds) else {
            return UIImage()
        }
        let croppedImage = UIImage(CGImage: imageRef, scale: scale, orientation: .Up)
        //CGImageRelease: CGImage now is mananged by ARC
        return croppedImage
    }
    
    func thumbnailImage(thumbnailSize: CGFloat, borderSize: Int, cornerRadius: Int, quality: CGInterpolationQuality)-> UIImage {
        let resizedImage = self.resizeImage(.ScaleAspectFill, bounds: CGSizeMake(thumbnailSize, thumbnailSize), quality: quality)
        let croppedRect = CGRectMake(round(resizedImage.size.width - thumbnailSize) / 2, (resizedImage.size.height - thumbnailSize) / 2, thumbnailSize, thumbnailSize)
        let croppedImage = self.croppedImage(croppedRect)
        return croppedImage
    }
    
    func resizeImage(contentMode: UIViewContentMode, bounds: CGSize, quality: CGInterpolationQuality)-> UIImage {
        let horizontalRatio = self.size.width / bounds.width
        let verticalRatio = self.size.height / bounds.height
        var ratio: CGFloat = 1.0
        
        switch contentMode {
        case .ScaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
            break
        
        case .ScaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
            break
            
        default:
            break
        }
        
        let newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio)
        return self.resizeImage(newSize, quality: quality)
    }
    
    func resizeImage(newSize: CGSize, quality: CGInterpolationQuality)-> UIImage {
        var drawTransposed = false
        switch self.imageOrientation {
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            drawTransposed = true
            break
        default:
            drawTransposed = false
            break
        }
        
        let transform = self.transformForOrientation(newSize)
        return resizeImage(newSize, transform: transform, drawTransposed: drawTransposed, interpolationQuality: quality)
    }
    
    //MARK: - Private Method
    
    private func resizeImage(newSize: CGSize, transform: CGAffineTransform, drawTransposed: Bool, interpolationQuality: CGInterpolationQuality)-> UIImage{
        let scale = max(1.0, self.scale)
        let newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height))
        let transportRect = CGRectMake(0, 0, newRect.height, newRect.width)
        
        let imageRef = self.CGImage
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmap = CGBitmapContextCreate(nil, Int(newRect.size.width), Int(newRect.size.height), 8, Int(newRect.width) * 4, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue & CGBitmapInfo.AlphaInfoMask.rawValue)
        
        CGContextConcatCTM(bitmap, transform)
        CGContextSetInterpolationQuality(bitmap, interpolationQuality)
        CGContextDrawImage(bitmap, drawTransposed ? transportRect : newRect, imageRef)
        
        let newImageRef = CGBitmapContextCreateImage(bitmap)
        let newImage = UIImage(CGImage: newImageRef!, scale: scale, orientation: self.imageOrientation)
        
        return newImage
    }
    
    private func transformForOrientation(newSize: CGSize) -> CGAffineTransform {
        var transform = CGAffineTransformIdentity
        
        switch (self.imageOrientation) {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break
            
        case .Left, .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            break
            
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break
            
        default:
            break
        }
        
        switch (self.imageOrientation) {
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break
            
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, newSize.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
            break
            
        default:
            break
        }
        
        return transform
    }
    
}

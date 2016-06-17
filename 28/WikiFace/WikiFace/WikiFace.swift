//
//  WikiFace.swift
//  WikiFace
//
//  Created by 季勤强 on 16/6/17.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class WikiFace: NSObject {
    
    enum WikiFaceError: ErrorType {
        case CouldNotDownLoadImage
    }
    
    class func faceOfPerson(personName: String, size: CGSize, completion: (image: UIImage?, imageFound: Bool!) -> ()) throws {
        
        let escapedString = personName.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let pixelsForApiRequest = Int(max(size.width, size.height)) * 2
        
        let url = NSURL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString!)&prop=pageimages&format=json&pithumbsize=\(pixelsForApiRequest)")
        
        guard let task: NSURLSessionTask? = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        
            if error == nil {
                
                //Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary.
                let wikiDict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                if let query = wikiDict.objectForKey("query") as? NSDictionary {
                    if let pages = query.objectForKey("pages") as? NSDictionary {
                        if let pageContent = pages.allValues.first as? NSDictionary {
                            if let thumbnail = pageContent.objectForKey("thumbnail") as? NSDictionary {
                                if let thumbURL = thumbnail.objectForKey("source") as? String {
                                    let faceImage = UIImage(data: NSData(contentsOfURL: NSURL(string: thumbURL)!)!)
                                    
                                    completion(image: faceImage, imageFound: true)
                                }
                            }else{
                                completion(image: nil, imageFound: false)
                            }
                        }
                    }
                }
            }
        
            
        }) else {
            throw WikiFaceError.CouldNotDownLoadImage
        }
        task?.resume()
    }
    
    class func centerImageViewOnFace (imageView: UIImageView) {
        
        let context = CIContext(options: nil)
        let options = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)
        
        let faceImage = imageView.image
        let ciImage = CIImage(CGImage: faceImage!.CGImage!)
        
        let features = detector.featuresInImage(ciImage)
        
        if features.count > 0 {
            
            var face:CIFaceFeature!
            
            for rect in features {
                face = rect as! CIFaceFeature
            }
            
            var faceRectWithExtendedBounds = face.bounds
            faceRectWithExtendedBounds.origin.x -= 20
            faceRectWithExtendedBounds.origin.y -= 30
            
            faceRectWithExtendedBounds.size.width += 40
            faceRectWithExtendedBounds.size.height += 60
            
            let x = faceRectWithExtendedBounds.origin.x / faceImage!.size.width
            let y = (faceImage!.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage!.size.height
            
            let widthFace = faceRectWithExtendedBounds.size.width / faceImage!.size.width
            let heightFace = faceRectWithExtendedBounds.size.height  / faceImage!.size.height
            
            imageView.layer.contentsRect = CGRectMake(x, y, widthFace, heightFace)
            
            
        }
    }
    
}

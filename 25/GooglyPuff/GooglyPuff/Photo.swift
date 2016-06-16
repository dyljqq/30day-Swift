//
//  Photo.swift
//  GooglyPuff
//
//  Created by 季勤强 on 16/6/15.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

typealias complete = (image: UIImage, error: NSError?) -> ()

enum PhotoStatus {
    case Downloading
    case GoodToGo
    case Failed
}

let kDownloadStatusNotification = "kDownloadStatusNotification"

class Photo: NSObject {
    
    var url: NSURL?
    var image: UIImage?
    var thumbnail: UIImage?
    var status: PhotoStatus?
    
    override init() {
        super.init()
    }
    
    init(url: NSURL, callback: complete) {
        super.init()
        self.url = url
        self.status = .Downloading
        downloadImage(callback)
    }
    
    var session: NSURLSession?
    
    func downloadImage(callback: complete) {
        var token: dispatch_once_t = 0
        dispatch_once(&token, {
            self.session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
        })
        let task = session?.dataTaskWithURL(url!, completionHandler: { data, response, error in
            guard let imageData = data else {
                print("data is nil")
                return ;
            }
            self.image = UIImage(data: imageData)
            if error == nil {
                self.status = .GoodToGo
            }else{
                self.status = .Failed
            }
            
//            self.thumbnail = self.image?.thumbnailImage(64, borderSize: 0, cornerRadius: 0, quality: .Default)
            
            callback(image: self.image!, error: error)
            
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName(kDownloadStatusNotification, object: nil)
            })
            
        })
        task?.resume()
    }
}

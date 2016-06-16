//
//  PhotoManager.swift
//  GooglyPuff
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

typealias BatchPhotoDownloading = (error: NSError?) -> ()

class PhotoManager: NSObject {
    
    var concurrentQueue: dispatch_queue_t?
    
    private var photoArray = [Photo]()
    
    static func sharedManaged()-> PhotoManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var staticInstance: PhotoManager? = nil
        }
        
        dispatch_once(&Static.onceToken, {
            Static.staticInstance = PhotoManager()
            Static.staticInstance?.concurrentQueue = dispatch_queue_create("com.selander.GooglyPuff.photoQueue", DISPATCH_QUEUE_CONCURRENT)
        })
        
        return Static.staticInstance!
        
    }
    
    func photos()-> Array<Photo> {
        var array: Array<Photo> = [Photo]()
        dispatch_sync(concurrentQueue!, {
            array.appendContentsOf(self.photoArray)
        })
        return array
    }
    
    func addPhoto(photo: Photo) {
        dispatch_barrier_async(self.concurrentQueue!, {
            self.photoArray.append(photo)
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName(kDownloadStatusNotification, object: nil)
            })
        })
    }
    
    func downloadPhoto(callback: BatchPhotoDownloading) {
        var error: NSError?
        let downloadGroup = dispatch_group_create()
        dispatch_apply(3, self.concurrentQueue, { i in
            var url: NSURL?
            switch i {
            case 0:
                url = NSURL(string: "http://i.imgur.com/UvqEgCv.png")
                break
            case 1:
                url = NSURL(string: "http://i.imgur.com/dZ5wRtb.png")
                break
            case 2:
                url = NSURL(string: "http://i.imgur.com/tPzTg7A.jpg")
                break
            default:
                break
            }
            
            dispatch_group_enter(downloadGroup)
            
            let photo = Photo(url: url!, callback: { image, _error in
                dispatch_group_leave(downloadGroup)
                print("image:\(i) count:\(self.photoArray.count)")
                if let err = _error {
                    error = err
                }
            })
            
            PhotoManager.sharedManaged().addPhoto(photo)
        })
        
        dispatch_group_notify(downloadGroup, self.concurrentQueue!, {
            callback(error: error)
        })
    }
    
}

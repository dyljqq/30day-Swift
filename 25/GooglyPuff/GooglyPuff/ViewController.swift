//
//  ViewController.swift
//  GooglyPuff
//
//  Created by 季勤强 on 16/6/15.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentChangedNotification:", name: kDownloadStatusNotification, object: nil)
        
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.alpha = 0.1
        imageView.contentMode = .Center
        self.collectionView?.addSubview(imageView)
        
        download()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideNavPrompt()
    }
    
    //MARK: - Delegate
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath)
        
        let imageView = cell.viewWithTag(8888) as! UIImageView
        let photo = PhotoManager.sharedManaged().photos()[indexPath.row]
        guard let status = photo.status else {
            print("status is nil")
            return cell;
        }
        switch status {
        case .Downloading:
            imageView.image = UIImage(named: "photoDownloading")
            break
        case .GoodToGo:
            imageView.image = photo.image
            break
        case .Failed:
            imageView.image = UIImage(named: "photoDownloadError")
            break
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoManager.sharedManaged().photos().count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let photo = PhotoManager.sharedManaged().photos()[indexPath.row]
        struct Message {
            var message: String?
            var title: String?
        }
        var message = Message()
        switch photo.status! {
        case .Downloading:
            message.message = "The image is currently downloading"
            message.title = "Downloading"
            break
        case .Failed:
            message.message = "The image failed to be created"
            message.title = "Image Failed"
            break
        case .GoodToGo:
            //TODO
            return
        }
        let alertController = UIAlertController(title: message.title, message: message.message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Notification
    
    func contentChangedNotification(notification: NSNotification) {
        showOrHideNavPrompt()
        self.collectionView?.reloadData()
    }
    
    //MARK: - Private Method
    
    func download() {
        PhotoManager.sharedManaged().downloadPhoto { error in
            let message = error != nil ? error!.localizedDescription : "The images have finished downloading"
            let alertController = UIAlertController(title: "Download Complete", message: message, preferredStyle: .Alert)            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func showOrHideNavPrompt() {
        let count = PhotoManager.sharedManaged().photos().count
        let delay = 1.0
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            if count == 0 {
                self.navigationItem.prompt = "Add photos with faces to Googlyify them!"
            }else{
                self.navigationItem.prompt = nil
            }
        })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


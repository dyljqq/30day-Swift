//
//  ViewController.swift
//  EasyShare
//
//  Created by 季勤强 on 16/5/6.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureNoteTextView()
    }
    
    func configureNoteTextView() {
        noteTextView.layer.cornerRadius = 8.0
        noteTextView.layer.borderWidth = 1.2
        noteTextView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).CGColor
    }

    @IBAction func showShareOptions(sender: AnyObject) {
        if noteTextView.isFirstResponder() {
            noteTextView.resignFirstResponder()
        }
        
        let actionSheet = UIAlertController(title: "", message: "Share your note", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookComposeVC.setInitialText("\(self.noteTextView.text)")
                self.presentViewController(facebookComposeVC, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage("You are not connected to your Facebook account.")
            }
        })
        let tweetAction = UIAlertAction(title: "Share on tweet", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                if self.noteTextView.text.characters.count <= 140 {
                    twitterComposeVC.setInitialText("\(self.noteTextView.text)")
                }else {
                   let index = self.noteTextView.text.startIndex.advancedBy(140)
                    let subText = self.noteTextView.text.substringToIndex(index)
                    twitterComposeVC.setInitialText("\(subText)")
                }
                self.presentViewController(twitterComposeVC, animated: true, completion: nil)
            }else {
                self.showAlertMessage("You are not logged in to your Twitter account.")
            }
        })
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: [self.noteTextView.text], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: nil)
        })
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
        })
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


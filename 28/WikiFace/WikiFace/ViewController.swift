//
//  ViewController.swift
//  WikiFace
//
//  Created by 季勤强 on 16/6/17.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var faceImageView: UIImageView!    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.nameTextField.delegate = self
        self.faceImageView.alpha = 0
        self.faceImageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        
    }
    
    //MARK: - Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if let content = textField.text {
            do {
                try WikiFace.faceOfPerson(content, size: CGSize(width: 300, height: 400), completion: { (image:UIImage?, imageFound:Bool!) -> () in
                    if imageFound == true {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.faceImageView.image = image
                            
                            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseIn, animations: { () -> Void in
                                
                                self.faceImageView.transform = CGAffineTransformMakeScale(1, 1)
                                self.faceImageView.alpha = 1
                                
                                //No, it's useful
                                self.faceImageView.layer.shadowOpacity = 0.4
                                self.faceImageView.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
                                self.faceImageView.layer.shadowRadius = 15.0
                                self.faceImageView.layer.shadowColor = UIColor.blackColor().CGColor
                                
                                }, completion: nil )
                            
                            WikiFace.centerImageViewOnFace(self.faceImageView)
                            
                        })
                    }
                    
                })
            }catch WikiFace.WikiFaceError.CouldNotDownLoadImage {
                print("Could not access wikipedia for downloading an image")
            }catch {
                print(error)
            }
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


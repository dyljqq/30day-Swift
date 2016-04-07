//
//  ViewController.swift
//  CoreImageFun
//
//  Created by 季勤强 on 16/4/7.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var amountSlider: UISlider!
    
    var context: CIContext!
    var filter: CIFilter!
    var beginImage: CIImage!
    var orientation: UIImageOrientation = .Up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png")
        
        beginImage = CIImage(contentsOfURL: fileURL!)
        
        //sepia:深褐色, tone:色调
        filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        context = CIContext(options: nil)
        getImage(0.5)
    }
    
    @IBAction func amountSliderValueChanged(sender: UISlider) {
        let sliderValue = sender.value
        getImage(sliderValue)
    }
    
    @IBAction func loadPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        let imageToSave = filter.outputImage!
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
        let cgImage = softwareContext.createCGImage(imageToSave, fromRect: imageToSave.extent)
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetCreationRequest.creationRequestForAssetFromImage(UIImage(CGImage: cgImage))
            }) {
                success, _ in
                if success {
                    print("save success")
                }else{
                    print("save failed")
                }
        }
    }
    
    func getImage(intensity: Float) {
        filter.setValue(intensity, forKey: kCIInputIntensityKey)
        let ciImage = context.createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent)
        let newImage = UIImage(CGImage: ciImage, scale: 1, orientation: orientation)
        self.imageView.image = newImage
    }
    
    //Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //图片从ciimage cgimage的转化，会使imageOrientation消失
        orientation = image.imageOrientation
        beginImage = CIImage(image: image)
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        self.amountSliderValueChanged(amountSlider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


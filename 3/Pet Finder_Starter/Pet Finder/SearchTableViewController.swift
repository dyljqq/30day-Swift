//
//  SearchTableViewController.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UITextFieldDelegate {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var numberOfPawsLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var searchProgress: UIProgressView!
  @IBOutlet weak var pawStepper: UIStepper!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var distanceSlider: UISlider!
  @IBOutlet weak var speciesSelector: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "dismiss")
    
    updateNumberOfPaws(pawStepper)
    updateDistance(distanceSlider)
    
    speciesSelector.setImage(UIImage(named: "dog"), forSegmentAtIndex: 0)
    speciesSelector.setImage(UIImage(named: "cat"), forSegmentAtIndex: 1)
  }
  
  func dismiss() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func hideKeyboard() {
    nameTextField.resignFirstResponder()
  }

  override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    hideKeyboard()
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    hideKeyboard()
    return true
  }
  
  @IBAction func updateDistance(sender: UISlider) {
    distanceLabel.text = "\(Int(sender.value)) miles"
  }
  
  @IBAction func updateNumberOfPaws(sender: UIStepper) {
    numberOfPawsLabel.text = "\(Int(sender.value)) paws"
  }
  
  @IBAction func search(sender: UIButton) {
    UIView.animateWithDuration(NSTimeInterval(5.0), animations: {
      self.searchProgress.setProgress(1.0, animated: true)
      self.view.alpha = 0.7
      }, completion: { finished in
        if finished {
          self.dismiss()
        }
    })
  }
}

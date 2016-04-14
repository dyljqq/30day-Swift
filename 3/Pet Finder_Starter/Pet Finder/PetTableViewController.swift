//
//  PetTableViewController.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

struct Pet {
  var name = ""
  var type = ""
}

let pets = [
  Pet(name: "Rusty", type: "Golder Retriever"),
  Pet(name: "Max", type: "Mixed Terrier"),
  Pet(name: "Lucifer", type: "Freaked Out"),
  Pet(name: "Tiger", type: "Sensitive Whiskers"),
  Pet(name: "Widget", type: "Mouse Catcher"),
  Pet(name: "Wiggles", type: "Border Collie"),
  Pet(name: "Clover", type: "Mixed Breed"),
  Pet(name: "Snow White", type: "Black Cat"),
]

class PetTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleImageView = UIImageView(image: UIImage(named: "catdog"))
    titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
    
    navigationItem.titleView = titleImageView
    
    let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "search")
    navigationItem.rightBarButtonItem = searchButton
    
    let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .Plain, target: self, action: "settings")
    navigationItem.leftBarButtonItem = settingsButton
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = ThemeManager.currentTheme().backgroundColor
    tableView.separatorColor = ThemeManager.currentTheme().secondaryColor
  }
    
  // MARK: - Search

  func search() {
    let searchViewController = (storyboard?.instantiateViewControllerWithIdentifier("SearchTableViewController"))! as UIViewController
    
    searchViewController.modalPresentationStyle = .Popover
    searchViewController.modalTransitionStyle = .CoverVertical
    searchViewController.popoverPresentationController?.delegate = self
    presentViewController(searchViewController, animated: true, completion: nil)
  }

  // MARK: - Settings
  
  func settings() {
    let settingsViewController = (storyboard?.instantiateViewControllerWithIdentifier("SettingsTableViewController"))! as UIViewController
    settingsViewController.modalPresentationStyle = .Popover
    settingsViewController.modalTransitionStyle = .CoverVertical
    settingsViewController.popoverPresentationController?.delegate = self
    presentViewController(settingsViewController, animated: true, completion: nil)
  }

  // MARK: - Popover
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.OverCurrentContext
  }
  
  func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    let navController = UINavigationController(rootViewController: controller.presentedViewController)
    
    return navController
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pets.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PetCell", forIndexPath: indexPath) 
    
    cell.imageView!.image = UIImage(named: "pet\(indexPath.row)")
    cell.imageView!.layer.masksToBounds = true
    cell.imageView!.layer.cornerRadius = 5
    
    cell.detailTextLabel!.text = pets[indexPath.row].type

    cell.textLabel!.text = pets[indexPath.row].name
    cell.textLabel!.font = UIFont(name: "Zapfino", size: 14.0)
    
    
    return cell
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowPet" {
      let selectedPetIndex = tableView.indexPathForCell(sender as! UITableViewCell)!.row
      (segue.destinationViewController as! PetViewController).petIndex = selectedPetIndex
    }
  }
}

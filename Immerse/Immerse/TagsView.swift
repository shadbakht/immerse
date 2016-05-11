//
//  TagsView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import JCTagListView

class TagsView: UIViewController {

  @IBOutlet var tagListView: JCTagListView!

  var tagViewModel : TagViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tagViewModel = TagViewModel(viewController: self)
    tagViewModel?.setup()
    
//    tagListView.canSelectTags = true
    tagListView.tagCornerRadius = 2.0
    //    self.tagListView.tagStrokeColor = [UIColor redColor];
    //    self.tagListView.tagBackgroundColor = [UIColor orangeColor];
    //    self.tagListView.tagTextColor = [UIColor greenColor];
    //    self.tagListView.tagSelectedBackgroundColor = [UIColor yellowColor];

    if let tagTypes = tagViewModel?.tagTypes {
      let strings = tagTypes.map({$0.name})
      tagListView.tags.addObjectsFromArray(strings)
    }
    tagListView.setCompletionBlockWithSelected({
      index in
      
      // On Select
      let vc = TagTypeDetailView(nibName: "TagTypeDetailView", bundle: nil)
      vc.tagType = self.tagViewModel!.tagTypes[index] // set the tagType
      self.navigationController?.pushViewController(vc, animated: true)
    })
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  @IBAction func createTag(sender: AnyObject) {
    let alert = UIAlertController(title: "Create a New Tag", message: "Please enter a tag name below.", preferredStyle: UIAlertControllerStyle.Alert)
    let ok = UIAlertAction(title: "OKAY", style: UIAlertActionStyle.Default, handler: {
      finished in
      if let textField = alert.textFields?.first {
        if self.tagViewModel!.createTagType(textField.text!.uppercaseString) {
          
          // Update the TagListView
          self.tagViewModel?.setup()
          if let types =  self.tagViewModel?.tagTypes {
            self.tagListView.tags.removeAllObjects()
            self.tagListView.tags.addObjectsFromArray(types.map({$0.name}))
            self.tagListView.collectionView.reloadData()
          }
        } else {
          //Failure
        }
      }
    })
    let cancel = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Default, handler: {
      finished in
    })
    alert.addTextFieldWithConfigurationHandler({
      textfield in
      textfield.placeholder = "Tag Name"
    })
    alert.addAction(cancel)
    alert.addAction(ok)
    self.presentViewController(alert, animated: true, completion: {
    })

  }
  
}

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
  
  @IBOutlet weak var tagToolbar: UIToolbar!
  @IBOutlet weak var shareToolbarButton: UIBarButtonItem!
  @IBOutlet weak var deleteToolbarButton: UIBarButtonItem!

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
      if !self.tagListView.canSelectTags {
        // Open the New View
        let vc = TagTypeDetailView(nibName: "TagTypeDetailView", bundle: nil)
        let tagType = self.tagViewModel!.tagTypes[index]
        vc.tagType = tagType // set the tagType
        self.navigationController?.pushViewController(vc, animated: true)
      } else {
      }
    })
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Actions
  
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
  
  @IBAction func toggleEdit(sender: UIBarButtonItem) {
    if sender.tag == 0 {
      displayToolBar(true)
      tagListView.canSelectTags = true
      tagListView.selectedTags.removeAllObjects()
      tagListView.collectionView.reloadData()
      sender.tag = 1
    } else {
      displayToolBar(false)
      self.shareToolbarButton.title = "Share All"
      self.deleteToolbarButton.title = "Delete All"
      tagListView.canSelectTags = false
      tagListView.selectedTags.removeAllObjects()
      tagListView.collectionView.reloadData()
      sender.tag = 0
    }
  }
  
  func displayToolBar(show:Bool) {
    if show {
      // Show
      UIView.animateWithDuration(0.3, animations: {
        let correctHeight = self.view.frame.height - 44
        let frame = self.tagToolbar.frame
        self.tagToolbar.frame = CGRectMake(frame.origin.x, correctHeight, frame.width, frame.height)
      })
    } else {
      // Hide
      UIView.animateWithDuration(0.3, animations: {
        let frame = self.tagToolbar.frame
        self.tagToolbar.frame = CGRectMake(frame.origin.x, self.view.frame.height, frame.width, frame.height)
      })
    }
  }
  
  @IBAction func shareTags(sender: UIBarButtonItem) {
  
  }
  
  @IBAction func deleteTags(sender: UIBarButtonItem) {
  
  }
  
  @IBAction func sortTags(sender: AnyObject) {
    let alert = UIAlertController(title: "Order Tags By", message: "Select a dimension to order your tags", preferredStyle: .ActionSheet)
    
    let firstAction = UIAlertAction(title: "Alphabetical [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
    }
    
    let secondAction = UIAlertAction(title: "Recently Added [Most->Least]", style: .Default) { (alert: UIAlertAction!) -> Void in
    }
    
    let thirdAction = UIAlertAction(title: "Number of Tags [High->Low]", style: .Default) { (alert: UIAlertAction!) -> Void in
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
      finished in
      
    })
    
    alert.addAction(firstAction)
    alert.addAction(secondAction)
    alert.addAction(thirdAction)
    alert.addAction(cancel)
    presentViewController(alert, animated: true, completion:nil)
    

  }
}

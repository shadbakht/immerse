//
//  CreateTagView.swift
//  Immerse
//
//  Created by James Tan on 4/24/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit
import JCTagListView

class CreateTagView: UIViewController {

  var tagViewModel : TagViewModel? = nil
  var record : Record? = nil
  var range : NSRange? = nil
  
  @IBOutlet var tagListView: JCTagListView!
  @IBOutlet var tagText: UILabel!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the ViewModel
    tagViewModel = TagViewModel(viewController: self)
    tagViewModel?.setup()
    
    // Populate the Text
    if (record != nil && range != nil) {
      let text = record!.record_text as NSString
      let substring = text.substringWithRange(range!)
      tagText.text = substring as String
    }
    
    // Popuplate TagsList
    tagListView.canSelectTags = true
    tagListView.tagCornerRadius = 2.0
    if let tagTypes = tagViewModel?.tagTypes {
      let strings = tagTypes.map({$0.name})
      tagListView.tags.addObjectsFromArray(strings)
    }
    tagListView.setCompletionBlockWithSelected({
      finished in
      // On Select
    })
  }
  
  @IBAction func close(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }
  
  @IBAction func add(sender: AnyObject) {
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

  @IBAction func applySelectedTags(sender: AnyObject) {
    
    // Get the Ids Of Selected Tag Types
    let indexSet = NSMutableIndexSet()
    _ = tagListView.selectedTags.map({ $0 as! String
      indexSet.addIndex(tagListView.tags.indexOfObject($0))
    })
    
    // Get the String Value of the Tag Types
    let tags = NSMutableArray(array:(tagViewModel?.tagTypes)!).objectsAtIndexes(indexSet)
    
    // Create the Tag
    tagViewModel?.createTag(record!, range: range!, types: tags as! [TagType])

    // Show the Alert Confirmation
    let alert = UIAlertController(title: "Tag Created", message: "Your tag was successfully created!", preferredStyle: UIAlertControllerStyle.Alert)
    let okay = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
      finished in
      self.dismissViewControllerAnimated(true, completion:nil)
    })
    alert.addAction(okay)
    super.presentViewController(alert, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

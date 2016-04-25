//
//  CreateTagView.swift
//  Immerse
//
//  Created by James Tan on 4/24/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class CreateTagView: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tagTable: UITableView!

  var tagViewModel : TagViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tagViewModel = TagViewModel(viewController: self)
    tagViewModel?.setup()
    
    tagTable.delegate = self
    tagTable.dataSource = self
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
        if self.tagViewModel!.createTagType(textField.text!) {
          self.tagViewModel?.setup()
          self.tagTable.reloadData()
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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = tagViewModel?.tagTypes.count {
      return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "moo!")
    let type : TagType = (tagViewModel?.tagTypes[indexPath.row])!
    cell.textLabel?.text = type.name
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.dismissViewControllerAnimated(true, completion: {
      
    })
  }
  
}

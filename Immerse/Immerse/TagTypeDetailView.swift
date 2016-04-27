//
//  TagTypeDetailView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class TagTypeDetailView: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tagListName: UINavigationItem!
  @IBOutlet var tagList: UITableView!
  
  var tagType : TagType? = nil
  override func viewDidLoad() {
    
    tagListName.title = tagType?.name
    
    tagList.delegate = self
    tagList.dataSource = self
    
    
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tagType!.tags.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MOO")
    
    let tag = tagType!.tags[indexPath.row]
    cell.textLabel?.text = tag.record?.record_text
    
    return cell
  }
  
  @IBAction func dismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {
      
    })
  }
}

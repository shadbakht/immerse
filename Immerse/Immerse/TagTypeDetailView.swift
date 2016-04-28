//
//  TagTypeDetailView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class TagTypeDetailView: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tagList: UITableView!
  
  var tagType : TagType? = nil
  override func viewDidLoad() {
    
    self.navigationController?.navigationItem.title = tagType!.name
    
    tagList.delegate = self
    tagList.dataSource = self
    
    let nib = UINib(nibName: "TagTypeDetail", bundle: nil)
    tagList.registerNib(nib, forCellReuseIdentifier: "TagTypeDetail")
    
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // 
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tagType!.tags.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("TagTypeDetail") as! TagTypeDetail
    let tag = tagType!.tags[indexPath.row]

    cell.loadTag(tag)

    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 125
  }
  
  //
}

//
//  TagsView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import RATreeView

class TagsView: UIViewController, RATreeViewDataSource, RATreeViewDelegate {

  @IBOutlet weak var tagTreeView: RATreeView!
  var edit : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Delegate and DataSource
    tagTreeView.delegate = self
    tagTreeView.dataSource = self
    
    // Get rideof tableview
    tagTreeView.treeFooterView = UIView(frame: CGRectZero)

    // Register the Cells
    self.tagTreeView.registerNib(
      UINib(nibName: "TagCell", bundle: nil),
      forCellReuseIdentifier: "TagCell"
    )
    self.tagTreeView.registerNib(
      UINib(nibName: "TagCellText", bundle: nil),
      forCellReuseIdentifier: "TagCellText"
    )
    
    // Observe
    Util.observe(self, action: #selector(TagsView.reload), named: "ReloadTagView")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  func reload() {
    tagTreeView.reloadData()
  }
  
  @IBAction func editPressed(sender: UIBarButtonItem) {
    if !edit {
      sender.title = "APPLY"
      edit = true
    } else {
      sender.title = "EDIT"
      edit = false
    }
    tagTreeView.reloadData()
  }
  
  //MARK: RATreeView Delegate
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    treeView.deselectRowForItem(item, animated: false)
    let level = treeView.levelForCellForItem(item)
    if level == 1 {
    }
  }
  
  //MARK: RATreeView DataSource
  func treeView(treeView: RATreeView, heightForRowForItem item: AnyObject) -> CGFloat {
    let level = treeView.levelForCellForItem(item)
    if level == 1 { return 100 }
    return 50
  }
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }
  
  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    if item == nil {
    } else {
      let data : RAObject = item as! RAObject
      return data.children.count
    }
    return 0
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = TagCell()
    return cell
  }
  
  

}

//
//  LibraryView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import RATreeView

class LibraryView: UIViewController, RATreeViewDataSource, RATreeViewDelegate {
  
  @IBOutlet weak var treeView: RATreeView!

  
  // MARK: Setup
  
  override func viewDidLoad() {
    
    // Setup the RATreeView
    treeView.delegate = self
    treeView.dataSource = self
    
    // Get rideof tableview
    treeView.treeFooterView = UIView(frame: CGRectZero)

    self.treeView.registerNib(UINib(nibName: "LibraryCell", bundle: nil), forCellReuseIdentifier: "LibraryCell")
    
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Navigation
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: RATreeView Delegate
  
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    let data : RAObject = item as! RAObject
    if data.pathName.containsString(".txt") {
    }
    
  }

  // MARK: RATreeView DataSource
  
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }

  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    let data : RAObject = item as! RAObject
    return data.children.count
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
  }


}

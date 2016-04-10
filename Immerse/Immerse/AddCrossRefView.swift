//
//  AddCrossRefView.swift
//  Immerse
//
//  Created by James Tan on 11/20/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class AddCrossRefView: UIViewController, RATreeViewDataSource, RATreeViewDelegate {

  @IBOutlet weak var refTitleLabel: UILabel!
  @IBOutlet weak var treeView: RATreeView!
  
  override func viewDidLoad() {
    
    // Setup the RATreeView
    treeView.delegate = self
    treeView.dataSource = self
    
    self.treeView.registerNib(UINib(nibName: "LibraryCell", bundle: nil), forCellReuseIdentifier: "LibraryCell")

    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //MARK: RATreeView Delegate
  
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    let data : RAObject = item as! RAObject
    if data.pathName.containsString(".txt") {
      self.performSegueWithIdentifier("showAddXrefBook", sender: self)
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

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
  
  var presenter : TagsPresenter? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup VIPER Stack
    let i = TagsInteractor()
    let p = TagsPresenter()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: RATreeView Delegate
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    print("something!")
  }
  
  //MARK: RATreeView DataSource
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
//    if item == nil {
//      return presenter!.mapping.objectAtIndex(index)
//    }
//    let data : RAObject = item as! RAObject
//    return data.children.objectAtIndex(index)
    return RAObject()
  }
  
  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
//    if item == nil {
//      return presenter!.mapping.count
//    } else {
//      let data : RAObject = item as! RAObject
//      return data.children.count
//    }
    return 0
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
//    let cell = presenter!.cellForTreeView(self.treeView, item: item)
    return UITableViewCell()
  }
  
  

}

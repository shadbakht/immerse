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

class LibraryViewCell : UITableViewCell {
  
}

class LibraryView: UIViewController, RATreeViewDataSource, RATreeViewDelegate {
  
  @IBOutlet weak var treeView: RATreeView!

  var presenter : LibraryPresenter? = nil
  
  // MARK: Setup
  
  override func viewDidLoad() {
    
    // Setup VIPER Stack
    presenter = LibraryPresenter.sharedInstance
    presenter?.view = self
    presenter?.interactor = LibraryInteractor.sharedInstance
    LibraryInteractor.sharedInstance.presenter = presenter
    LibraryPresenter.sharedInstance.setup()

    // Setup the RATreeView
    treeView.delegate = self
    treeView.dataSource = self
    
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
  
  func treeView(treeView: RATreeView!, didSelectRowForItem item: AnyObject!) {
  }

  // MARK: RATreeView DataSource
  
  func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
    if item == nil {
      return presenter!.mapping.objectAtIndex(index)
    }
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }

  func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
    if item == nil {
      return presenter!.mapping.count
    } else {
      let data : RAObject = item as! RAObject
      return data.children.count
    }
  }
  
  func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
    let dataObject : RAObject = item as! RAObject
    let level = self.treeView.levelForCellForItem(item)
    let numberOfChildren = dataObject.children.count
    let detailText = "TEST"
    let expanded = self.treeView.isCellForItemExpanded(item)
    
    //
    print(level)
    print(numberOfChildren)
    print(detailText)
    print(expanded)
    
    let cell = UITableViewCell()
    cell.textLabel!.text = dataObject.displayName
    return cell
  }


}

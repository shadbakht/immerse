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
import RADataObject

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
  
  //MARK: RATreeView Delegate / DataSource

  func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
    print("Get NUMBE ROF CHILDREN")
    return (presenter?.numberOfChildren(treeView, index: item))!
  }
  
  func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
    print("GET CELL")
    let cell = presenter?.cellForTree(treeView, index: item)
    return cell
  }
  
  func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
    print("DECIDE CHILD")
    print(index)
    RADa
    return index
  }
  
  func treeView(treeView: RATreeView!, didSelectRowForItem item: AnyObject!) {
    print("I GOT SELECTED")
    presenter?.selectRowForTree(treeView, index: item)
  }


}

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
    
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: RATreeView Delegate / DataSource
  func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
    if item == nil {
      return presenter!.numberOfSections()
    } else {
      let itemCount = item as! Int
      return presenter!.numberOfRowsForSection(itemCount)
    }
  }
  
  func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
    let a = UITableViewCell()
    if item == nil {
      a.textLabel!.text = "Paarent"
      return a
    } else {
      return presenter!.cellForRow(treeView, row: (item as! Int))
    }
  }
  
  func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
    return index
  }
  
  func treeView(treeView: RATreeView!, didSelectRowForItem item: AnyObject!) {
    print("Hello!")
    presenter!.selectCell((item as! Int), row: (item as! Int))
  }


}

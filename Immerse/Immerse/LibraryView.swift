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

  var presenter : LibraryPresenter? = nil
  
  // MARK: Setup
  
  override func viewDidLoad() {
    
    // Setup VIPER Stack
    let i = LibraryInteractor()
    let p = LibraryPresenter()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter
    presenter?.setup()
    
    // Setup the RATreeView
    treeView.delegate = self
    treeView.dataSource = self
    
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
      presenter!.selectWriting(data)      
    }
    
  }

  // MARK: RATreeView DataSource
  
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    if item == nil {
      return presenter!.mapping.objectAtIndex(index)
    }
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }

  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    if item == nil {
      return presenter!.mapping.count
    } else {
      let data : RAObject = item as! RAObject
      return data.children.count
    }
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = presenter!.cellForTreeView(self.treeView, item: item)
    return cell
  }


}

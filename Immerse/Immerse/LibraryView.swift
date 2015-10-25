//
//  LibraryView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class LibraryViewCell : UITableViewCell {
  
}

class LibraryView: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var presenter : LibraryPresenter? = nil
  
  override func viewDidLoad() {
    
    // Setup VIPER Stack
    presenter = LibraryPresenter.sharedInstance
    presenter?.view = self
    presenter?.interactor = LibraryInteractor.sharedInstance
    LibraryInteractor.sharedInstance.presenter = presenter
    LibraryPresenter.sharedInstance.setup()

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

  //MARK: UITableView Delegate / DataSource
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = presenter?.cellForRow(tableView, indexPath:indexPath)
    return cell!
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // Something
    presenter?.selectCell(indexPath)
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return presenter?.titleForSection(section)
  }
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return (presenter?.numberOfSections())!
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (presenter?.numberOfRowsForSection(section))!
  }

}

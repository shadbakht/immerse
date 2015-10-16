//
//  NavTray.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class NavTray: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Table view data source

//  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return 0
//  }
//
//  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 0
//  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      let mainNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigation") as! UINavigationController
      let backgroundColor: UIColor
      switch indexPath.row {
      case 0:
        backgroundColor = UIColor.redColor()
      case 1:
        backgroundColor = UIColor.blueColor()
      default:
        backgroundColor = UIColor.whiteColor()
      }
      mainNavigation.topViewController?.view.backgroundColor = backgroundColor
      drawerController.mainViewController = mainNavigation
      drawerController.setDrawerState(.Closed, animated: true)
    }
  }
  


}

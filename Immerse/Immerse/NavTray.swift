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
    Util.observe(self, action: "goToLibrary", named: "ShowLibrary")
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func goToLibrary() {
    if let drawerController = self.parentViewController as? KYDrawerController {
      let mainNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigation") as! UINavigationController
      mainNavigation.performSegueWithIdentifier("showLibrary", sender: self)
      drawerController.mainViewController = mainNavigation
      drawerController.setDrawerState(.Closed, animated: true)
    }
  }
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if let drawerController = self.parentViewController as? KYDrawerController {
      let mainNavigation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigation") as! UINavigationController
      switch indexPath.row {
      case 0:
        mainNavigation.popToRootViewControllerAnimated(true)
      case 1:
        mainNavigation.popToRootViewControllerAnimated(true)
      case 2:
        mainNavigation.performSegueWithIdentifier("showLibrary", sender: self)
      case 3:
        mainNavigation.performSegueWithIdentifier("showTags", sender: self)
      case 4:
        mainNavigation.performSegueWithIdentifier("showNotes", sender: self)
      case 5:
        mainNavigation.performSegueWithIdentifier("showCrossRefs", sender: self)
      case 6:
        mainNavigation.performSegueWithIdentifier("showSettings", sender: self)
      case 8:
        mainNavigation.performSegueWithIdentifier("showReader", sender: self)
      default:
        mainNavigation.popToRootViewControllerAnimated(true)
      }
      drawerController.mainViewController = mainNavigation
      drawerController.setDrawerState(.Closed, animated: true)
    }
  }
  


}

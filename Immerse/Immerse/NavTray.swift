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
    Util.observe(self, action: "goToReader", named: "ShowReader")
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func goToLibrary() {
    if let drawerController = self.parentViewController as? KYDrawerController {
      Util.notifyData("LaunchView",
        data: ["name":2]
      )
      drawerController.setDrawerState(.Closed, animated: true)
    }
  }
  
  func goToReader() {
    if let drawerController = self.parentViewController as? KYDrawerController {
      Util.notifyData("LaunchView",
        data: ["name":8]
      )
      drawerController.setDrawerState(.Closed, animated: false)
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if let drawerController = self.parentViewController as? KYDrawerController {
      
      // Launch the appropriate segue
      Util.notifyData("LaunchView",
        data: ["name":indexPath.row]
      )
      
      // Close the Drawer
      drawerController.setDrawerState(.Closed, animated: true)
    }
  }
  


}

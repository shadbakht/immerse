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

  
  // MARK: - Table view data source
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    launchView(indexPath: indexPath)
  }
  
  func goToLibrary() {
    launchView(2)
  }
  
  func goToReader() {
    launchView(8)
  }
  
  func launchView(index:NSInteger?=nil, indexPath:NSIndexPath?=nil) {
    if let drawerController = self.parentViewController as? KYDrawerController {
      
      // Get the Index
      var number = 0
      if index != nil { number = index! }
      if indexPath != nil { number = indexPath!.row }
      
      // Launch the appropriate segue
      Util.notifyData("LaunchView",
        data: ["name":number]
      )
      
      // Close the Drawer
      drawerController.setDrawerState(.Closed, animated: true)
    }

  }
  


}

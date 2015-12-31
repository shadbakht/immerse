//
//  IMNavControl.swift
//  Immerse
//
//  Created by James Tan on 12/31/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class IMNavControl: UINavigationController {

  override func viewDidLoad() {
    Util.observe(self, action: "goToView:", named:"LaunchView")
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func goToView(notif:NSNotification) {
    let values = notif.userInfo
    if let vals = values {
      if let name = vals["name"] as? NSInteger {
        var segueName = ""
        switch name {
          case 2:
          segueName = "showLibrary"
          case 3:
          segueName = "showTags"
          case 4:
          segueName = "showNotes"
          case 5:
          segueName = "showCrossRefs"
          case 6:
          segueName = "showSettings"
          case 8:
          segueName = "showReader"
        default:
          segueName = ""
          break
        }
        if segueName != "" {
          self.performSegueWithIdentifier(segueName, sender: self)
        } else {
          self.popToRootViewControllerAnimated(true)
        }
        
      }
    }
  }

}

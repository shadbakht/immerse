//
//  TagsView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class TagsView: UIViewController {

  var edit : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Observe
    Util.observe(self, action: #selector(TagsView.reload), named: "ReloadTagView")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  func reload() {
  }
  
  @IBAction func editPressed(sender: UIBarButtonItem) {
    if !edit {
      sender.title = "APPLY"
      edit = true
    } else {
      sender.title = "EDIT"
      edit = false
    }
  }
}

//
//  NotesView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class NotesView: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Observe
    Util.observe(self, action: #selector(NotesView.reload), named: "ReloadNoteView")

  }

  func reload() {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }

}

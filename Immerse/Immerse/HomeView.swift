//
//  HomeView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class HomeView: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func didTapOpenButton(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }

}
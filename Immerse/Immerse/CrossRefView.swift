//
//  CrossRefView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import RATreeView

class CrossRefView: UIViewController {

  var presenter : CrossRefPresenter? = nil
  
  @IBOutlet weak var refTreeView: RATreeView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup VIPER
    let p = CrossRefPresenter()
    let i = CrossRefInteractor()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter
    presenter?.setup()

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

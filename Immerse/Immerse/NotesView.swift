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

  var presenter : NotesPresenter? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the VIPER Stack
    let p = NotesPresenter()
    let i = NotesInteractor()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter
    
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

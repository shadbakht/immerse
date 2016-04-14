//
//  LibraryView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import XLPagerTabStrip

class LibraryView: ButtonBarPagerTabStripViewController {
  
  var faithViewModel : FaithViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settings.style.buttonBarItemBackgroundColor = UIColor.clearColor()
    buttonBarView.backgroundColor = UIColor.clearColor()
    settings.style.buttonBarItemTitleColor = UIColor.darkGrayColor()
    settings.style.selectedBarBackgroundColor = UIColor.greenColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Navigation
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
    faithViewModel = FaithViewModel(viewController: self)
    faithViewModel?.setup()
    
    if let views = faithViewModel?.faiths.map({
      
      LibrarySubView(itemInfo: IndicatorInfo(title: $0.name), faith: $0)
      }) {
      return views
    }
    return []
  }
  
}

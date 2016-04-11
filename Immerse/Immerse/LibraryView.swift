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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    settings.style.buttonBarBackgroundColor = UIColor.redColor()
    settings.style.buttonBarItemBackgroundColor = UIColor.clearColor()
    buttonBarView.backgroundColor = UIColor.clearColor()
//    settings.style.selectedBarBackgroundColor = UIColor.clearColor()
    settings.style.buttonBarItemTitleColor = UIColor.darkGrayColor()
    settings.style.selectedBarHeight = 1.0
    settings.style.buttonBarHeight = 1.0
    settings.style.buttonBarMinimumLineSpacing = 20
    settings.style.buttonBarMinimumInteritemSpacing = 20
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
    let vc1 = LibrarySubView(itemInfo: "ALL FAITHS")
    let vc2 = LibrarySubView(itemInfo: "CHRISTIAN")
    let vc3 = LibrarySubView(itemInfo: "BAHA'I")
    let vc4 = LibrarySubView(itemInfo: "ISLAM")
    let vc5 = LibrarySubView(itemInfo: "BUDDHISM")
    let vc6 = LibrarySubView(itemInfo: "HINDUISM")
    let vc7 = LibrarySubView(itemInfo: "SHINTO")
    let vc8 = LibrarySubView(itemInfo: "NATIVE AMERICAN")
    let vc9 = LibrarySubView(itemInfo: "TAOISM")
    let vc10 = LibrarySubView(itemInfo: "CONFUCIANISM")

    return [vc1, vc2, vc3, vc4, vc5,vc6, vc7, vc8, vc9, vc10 ]
  }
  
}

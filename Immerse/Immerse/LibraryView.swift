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

enum SortOption {
  case None
  case BookRecent
  case BookAlphabetical
  case AuthorAlphabetical
}

class LibraryView: ButtonBarPagerTabStripViewController {
  var sortingChoice : SortOption = SortOption.None
  var faithViewModel : FaithViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    settings.style.buttonBarItemBackgroundColor = UIColor.clearColor()
    buttonBarView.backgroundColor = UIColor.imBackground
    settings.style.buttonBarItemTitleColor = UIColor.darkGrayColor()
    settings.style.selectedBarBackgroundColor = UIColor.imBlue
    settings.style.selectedBarHeight = 1.3
    
    faithViewModel = FaithViewModel(viewController: self)
    faithViewModel?.setup()
    
    if let views = faithViewModel?.faiths.map({
      LibrarySubView(itemInfo:
        IndicatorInfo(title: $0.name), faith: $0, sorting: self.sortingChoice )
      }) {
      return views
    }
    return []
  }
  
  @IBAction func showSortingOptions(sender: AnyObject) {
    let alert = UIAlertController(title: "Sort By Library By", message: "Select a dimension to sort along.", preferredStyle: .ActionSheet)

    let firstAction = UIAlertAction(title: "Writing Name [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sortingChoice = SortOption.BookAlphabetical
      self.reloadPagerTabStripView()
    }
    
    let secondAction = UIAlertAction(title: "Author Name [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sortingChoice = SortOption.AuthorAlphabetical
      self.reloadPagerTabStripView()
    }
    
    let thirdAction = UIAlertAction(title: "Recently Opened", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sortingChoice = SortOption.BookRecent
      // Do something with the viewModel at this point
      self.reloadPagerTabStripView()

    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
      finished in
      
    })

    alert.addAction(thirdAction)
    alert.addAction(firstAction)
    alert.addAction(secondAction)
    alert.addAction(cancel)
    presentViewController(alert, animated: true, completion:nil)

  }
}

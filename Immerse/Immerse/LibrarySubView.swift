//
//  LibrarySubView.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LibrarySubView: UITableViewController, IndicatorInfoProvider {

  var itemInfo: IndicatorInfo = "View"
  var faith : Faith? = nil
  var bookViewModel : BookViewModel? = nil
  
  init(itemInfo: IndicatorInfo, faith: Faith) {
    self.itemInfo = itemInfo
    self.faith = faith
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bookViewModel = BookViewModel(viewController: self)
    bookViewModel?.setup()

    let nib = UINib(nibName: "LibraryBookCell", bundle: nil)
    tableView.registerNib(nib, forCellReuseIdentifier: "LibraryBookCell")
  }
  
  // MARK: - IndicatorInfoProvider
  
  func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return itemInfo
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("LibraryBookCell")
    return cell!
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = faith?.books.count {
      return count
    }
    return 1
  }
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    return 150
  }
  
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

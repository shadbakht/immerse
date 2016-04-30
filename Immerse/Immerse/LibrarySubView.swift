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
  var books : [Book]? = nil
  var bookViewModel : BookViewModel? = nil
  
  init(itemInfo: IndicatorInfo, faith: Faith) {
    self.itemInfo = itemInfo
    self.faith = faith
    self.books = faith.books
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bookViewModel = BookViewModel(viewController: self)
    bookViewModel?.setup()

    // Register Nibs
    
    let nib = UINib(nibName: "LibraryBookCell", bundle: nil)
    tableView.registerNib(nib, forCellReuseIdentifier: "LibraryBookCell")
    tableView.tableFooterView = UIView()

  }
  
  // MARK: - IndicatorInfoProvider
  
  func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return itemInfo
  }
  
  // MARK: - TableViewDelegate & DataSource
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("LibraryBookCell") as! LibraryBookCell
    let bookObj = books![indexPath.row]
    cell.bookTitleLabel.text = bookObj.name
    cell.bookAuthorLabel.text = bookObj.author?.name
    
    return cell
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = books?.count {
      return count
    }
    return 1
  }
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let readerVc = ReaderView(nibName: "ReaderView", bundle: nil)
    readerVc.load(books![indexPath.row])
    self.presentViewController(readerVc, animated: true, completion: {
      
    })
  }

}

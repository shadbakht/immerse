//
//  CrossRefView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class CrossRefView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var crossRefViewModel : CrossRefViewModel? = nil
  private var sorting : SortOption = SortOption.None
  private var uniqueBooks : [Book] = []
  @IBOutlet var crossRefTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup ViewModel
    crossRefViewModel = CrossRefViewModel(viewController: self)
    crossRefViewModel?.setup()
    
    // Setup Table
    crossRefTableView.delegate = self
    crossRefTableView.dataSource = self
    let nib = UINib(nibName: "CrossRefCell", bundle: nil)
    crossRefTableView.registerNib(nib, forCellReuseIdentifier: "CrossRefCell")
    crossRefTableView.tableFooterView = UIView()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    switch sorting {
    case SortOption.BookAlphabetical:
      return self.uniqueBooks.count
    default:
      return 1
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[section]
      let sectionBooks = self.crossRefViewModel!.crossRefs!.filter({
        print($0.source_ref!.book?.name)
        return ($0.source_ref!.book!.isEqual(book))
      })
      return sectionBooks.count
    default:
      return crossRefViewModel!.crossRefs!.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[indexPath.section]
      let sectionBooks = self.crossRefViewModel!.crossRefs!.filter({
        ($0.source_ref!.book == book)
      })
      let refs = sectionBooks[indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier("CrossRefCell") as! CrossRefCell
      cell.loadCrossRef(refs)
      return cell
    default:
      let cross = crossRefViewModel!.crossRefs![indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier("CrossRefCell") as! CrossRefCell
      cell.loadCrossRef(cross)
      return cell
    }
  }
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[section]
      return book.name
    default:
      return nil
    }
  }
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  //
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  @IBAction func showSortingOptions(sender: AnyObject) {
    let alert = UIAlertController(title: "Group Cross References By", message: "Select a dimension to group your cross references along.", preferredStyle: .ActionSheet)
    
    let firstAction = UIAlertAction(title: "Writing [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookAlphabetical
      
      // Sort the Books
      let books = self.crossRefViewModel!.crossRefs!.map({$0.source_ref!.book!})
      self.uniqueBooks = NSSet(array: books).allObjects as! [Book]
      
      self.crossRefTableView.reloadData()
    }
    
    let thirdAction = UIAlertAction(title: "Recent", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookRecent
      self.crossRefTableView.reloadData()
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
      finished in
      
    })
    
    alert.addAction(firstAction)
    alert.addAction(thirdAction)
    alert.addAction(cancel)
    presentViewController(alert, animated: true, completion:nil)
    
  }
  

  
}

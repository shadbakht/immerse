//
//  ReaderView.swift
//  Immerse
//
//  Created by James Tan on 4/15/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class ReaderView: UIViewController , UITableViewDataSource, UITableViewDelegate  {

  @IBOutlet var navbar: UINavigationBar!
  @IBOutlet var toolbar: UIToolbar!
  @IBOutlet var readerTable: UITableView!
  
  private var records : [Record]? = nil
  private var hidden : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    readerTable.delegate = self
    readerTable.dataSource = self
//    readerTable.rowHeight = UITableViewAutomaticDimension
    
    let nib = UINib(nibName: "ReaderCell", bundle: nil)
    readerTable.registerNib(nib, forCellReuseIdentifier: "ReaderCell")
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(toggleTools))
    tap.numberOfTapsRequired = 1
    readerTable.addGestureRecognizer(tap)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func load(book:Book) {
    records = book.records
  }
  
  func toggleTools() {
    if (hidden) {
      // Show
      hidden = false
      UIView.animateWithDuration(0.3, animations: {
        self.navbar.frame.setY(0)
        self.toolbar.frame.setY(self.readerTable.frame.height-self.toolbar.frame.height)
      })
    } else {
      // Hide
      hidden = true
      UIView.animateWithDuration(0.3, animations: {
        self.navbar.frame.setY(-self.navbar.frame.height)
        self.toolbar.frame.setY(self.readerTable.frame.height)
      })
    }
  }
  
  @IBAction func close(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = records?.count {
      return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let record = records![indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("ReaderCell") as! ReaderCell
    cell.textView.text = record.record_text
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  @IBAction func addCrossRef(sender: AnyObject) {
  }
  @IBAction func addNote(sender: AnyObject) {
  }
  @IBAction func addTag(sender: AnyObject) {
    let create = CreateTagView(nibName: "CreateTagView", bundle: nil)
    self.showDetailViewController(create, sender: self)
  }

}

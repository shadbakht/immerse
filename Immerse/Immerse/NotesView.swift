//
//  NotesView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class NotesView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var notesTableView: UITableView!
  
  var noteViewModel : NoteViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    noteViewModel = NoteViewModel(viewController: self)
    noteViewModel?.setup()
    
    notesTableView.delegate = self
    notesTableView.dataSource = self
    
    let nib = UINib(nibName: "NotesCell", bundle: nil)
    notesTableView.registerNib(nib, forCellReuseIdentifier: "NotesCell")
    notesTableView.tableFooterView = UIView()

  }

  //
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count =  noteViewModel?.notes?.count {
      return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NotesCell") as! NotesCell
    let note = noteViewModel!.notes![indexPath.row]
    cell.loadNote(note)
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
  
  // 
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  
  @IBAction func showSortingOptions(sender: AnyObject) {
    let alert = UIAlertController(title: "Group Notes By", message: "Select a dimension to group your notes along.", preferredStyle: .ActionSheet)
    
    let firstAction = UIAlertAction(title: "Writing [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
    }
    
    let secondAction = UIAlertAction(title: "Author [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
    }
    
    let thirdAction = UIAlertAction(title: "Recent", style: .Default) { (alert: UIAlertAction!) -> Void in
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

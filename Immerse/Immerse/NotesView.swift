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
    return 200
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

}

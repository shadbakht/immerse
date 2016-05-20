//
//  HomeView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class HomeView: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var countTagLabel: UILabel!
  @IBOutlet weak var countNoteLabel: UILabel!
  @IBOutlet weak var countXRefLabel: UILabel!
  @IBOutlet weak var table: UITableView!
  
  var progressViewModel : ProgressViewModel? = nil
  var tagViewModel : TagViewModel? = nil
  var noteViewModel : NoteViewModel? = nil
  var crossRefViewModel : CrossRefViewModel? = nil
  
  override func viewDidLoad() {
    
    // Configure the ProgressViewModel
    progressViewModel = ProgressViewModel(viewController: self)
    progressViewModel?.setup()
    
    // COnfigure the TagViewModel
    tagViewModel = TagViewModel(viewController: self)
    tagViewModel?.setup()
    
    // Configure the NoteViewModel
    noteViewModel = NoteViewModel(viewController: self)
    noteViewModel?.setup()
    
    crossRefViewModel = CrossRefViewModel(viewController: self)
    crossRefViewModel?.setup()
    
    // Configure the TableView
    let nib = UINib(nibName: "RecentCell", bundle: nil)
    table.registerNib(nib, forCellReuseIdentifier: "RecentCell")
    table.tableFooterView = UIView(frame: CGRectZero)
    table.delegate = self
    table.dataSource = self

    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    progressViewModel?.setup()
    tagViewModel?.setup()
    noteViewModel?.setup()
    crossRefViewModel?.setup()
    
    countTagLabel.text = tagViewModel!.tags.count.stringValue()
    countNoteLabel.text = noteViewModel!.notes!.count.stringValue()
    countXRefLabel.text = crossRefViewModel!.crossRefs!.count.stringValue()
    table.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: UITableViewDatasource and UITableViewDelegate Methods
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RecentCell") as! RecentCell
    let progress = progressViewModel!.progress[indexPath.row] 
    
    let tagCount = tagViewModel!.tags.filter({
      return ($0.record!.book!.isEqual(progress.writing!))
    }).count
    let noteCount = noteViewModel!.notes!.filter({
      $0.record!.book!.isEqual(progress.writing!)
    }).count

    let refCount = crossRefViewModel!.crossRefs!.filter({
      $0.source_ref!.book!.isEqual(progress.writing!)
    }).count

    cell.load(progress,
              tagCount: tagCount, noteCount: noteCount, refCount: refCount)
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let cell = tableView.cellForRowAtIndexPath(indexPath) as! RecentCell
    let readerVc = ReaderView(nibName: "ReaderView", bundle: nil)
    readerVc.load(cell.book!)
    self.presentViewController(readerVc, animated: true, completion:nil)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.progressViewModel!.progress.count
  }
  
  // MARK: Open Menu
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  // MARK: Navigation
  @IBAction func launchLibrary(sender: AnyObject) {
    Util.notify("ShowLibrary")
  }

}

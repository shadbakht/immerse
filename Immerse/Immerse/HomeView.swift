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

  override func viewDidLoad() {
    
    // Configure the ProgressViewModel
    progressViewModel = ProgressViewModel(viewController: self)
    progressViewModel?.setup()
    
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
    table.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: UITableViewDatasource and UITableViewDelegate Methods
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RecentCell") as! RecentCell
    cell.load(progressViewModel!.progress[indexPath.row], tagCount: 0, noteCount: 0, refCount: 0)
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
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

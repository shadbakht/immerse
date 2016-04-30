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
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (crossRefViewModel != nil) {
      return crossRefViewModel!.crossRefs!.count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cross = crossRefViewModel!.crossRefs![indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("CrossRefCell") as! CrossRefCell
    cell.loadCrossRef(cross)
    
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
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
}

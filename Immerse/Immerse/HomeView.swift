//
//  HomeView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class HomeViewCell : UITableViewCell {
  
  @IBOutlet weak var writingProgressLabel: UILabel!
  @IBOutlet weak var writingTitleLabel: UILabel!
  @IBOutlet weak var writingCompleteLabel: NSLayoutConstraint!
  @IBOutlet weak var writingSubTitleLabel: UILabel!
  @IBOutlet weak var writingCompletedProgressBar: UIProgressView!
  
}

class HomeView: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var presenter : HomePresenter? = nil
  @IBOutlet weak var countTagLabel: UILabel!
  @IBOutlet weak var countNoteLabel: UILabel!
  @IBOutlet weak var countXRefLabel: UILabel!
  @IBOutlet weak var table: UITableView!
  
  override func viewDidLoad() {
    
    // Setup VIPER Stack
    let p = HomePresenter()
    let i = HomeInteractor()
    presenter = p
    presenter?.interactor = i
    presenter?.view = self
    i.presenter = presenter
    presenter?.setup()
    
    countTagLabel.setTextForInt(presenter!.totalTagCount)
    countNoteLabel.setTextForInt(presenter!.totalNoteCount)
    countXRefLabel.setTextForInt(presenter!.totalXRefCount)
    
    // Get rideof tableview
    table.tableFooterView = UIView(frame: CGRectZero)

    super.viewDidLoad()
    
    Util.observe(self, action: "reload", named: "ReloadTagView")
    Util.observe(self, action: "reload", named: "ReloadNoteView")
    Util.observe(self, action: "reload", named: "ReloadRefView")

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func reload() {
    presenter?.setup()
    countTagLabel.setTextForInt(presenter!.totalTagCount)
    countNoteLabel.setTextForInt(presenter!.totalNoteCount)
    countXRefLabel.setTextForInt(presenter!.totalXRefCount)
    table.reloadData()
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
  
  // MARK: UITableViewDatasource and UITableViewDelegate Methods
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = presenter?.recentlyViewedCellForIndex(tableView, indexPath:indexPath)
    return cell!
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    presenter?.selectCell(indexPath)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (presenter?.numberOfRecentlyViewed())!
  }
}

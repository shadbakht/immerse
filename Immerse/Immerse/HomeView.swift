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

  override func viewDidLoad() {
    
    // Setup VIPER Stack
    presenter = HomePresenter.sharedInstance
    presenter?.interactor = HomeInteractor.sharedInstance
    presenter?.view = self
    HomeInteractor.sharedInstance.presenter = presenter
    HomePresenter.sharedInstance.setup()

    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
    presenter?.selectCell(indexPath)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (presenter?.numberOfRecentlyViewed())!
  }
}

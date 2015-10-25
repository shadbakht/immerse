//
//  HomePresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class HomePresenter: NSObject {

  static let sharedInstance : HomePresenter = HomePresenter()
  var interactor : HomeInteractor? = nil
  var view : HomeView? = nil
  var isSetup : Bool = false
  var recentlyViewedWritings : NSMutableArray = []
  
  func setup() {
    if !isSetup {
      isSetup = true
    }
  }
  
  func numberOfRecentlyViewed() -> Int {
    return 1
  }

  func recentlyViewedCellForIndex(tableView:UITableView, indexPath: NSIndexPath) -> HomeViewCell? {
//    let row = indexPath.row
//    if row > (recentlyViewedWritings.count - 1) || row < 0 { return self.createEmptyCell() }
    
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeViewCell", forIndexPath: indexPath) as? HomeViewCell
    cell?.writingTitleLabel.text = "Hellow WOrld!"
    return cell
    
  }
  
  func createEmptyCell() -> HomeViewCell {
    return HomeViewCell()
  }
}

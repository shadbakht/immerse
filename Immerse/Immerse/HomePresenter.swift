//
//  HomePresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class HomePresenter: NSObject {

  var interactor : HomeInteractor? = nil
  weak var view : HomeView? = nil
  var recentlyViewedWritings : NSArray = []
  var totalTagCount = 0
  var totalNoteCount = 0
  var totalXRefCount = 0
  
  func setup() {
    recentlyViewedWritings = interactor!.getRecent()
    let counts = interactor!.getObjectCounts()
    totalTagCount = counts.tags
    totalNoteCount = counts.notes
    totalXRefCount = counts.xRefs
  }
  
  func numberOfRecentlyViewed() -> Int {
    return recentlyViewedWritings.count
  }

  func selectCell(indexPath:NSIndexPath) {
    let row = indexPath.row
  }
  func recentlyViewedCellForIndex(tableView:UITableView, indexPath: NSIndexPath) -> HomeViewCell? {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeViewCell", forIndexPath: indexPath) as? HomeViewCell
    let row = indexPath.row
    let subtitle = createSubtitleFromCount(counts.notes, tags: counts.tags, refs: counts.refs)
    
    cell?.writingCompletedProgressBar.progress = data.progress
    cell?.writingProgressLabel.text = data.text
    cell?.writingSubTitleLabel.text = subtitle
    
    return cell
    
  }
  
  func createEmptyCell() -> HomeViewCell {
    return HomeViewCell()
  }
  
  func createSubtitleFromCount(notes:Int, tags:Int, refs:Int) -> String {
    let total : NSMutableArray = []
    let noteString = String(format:"%d NOTE", notes)
    let tagString = String(format:"%d TAG", tags)
    let refString = String(format:"%d X-REF", refs)
    
    if notes != 0 { total.addObject((notes == 1) ? noteString : noteString + "S") }
    if tags != 0 { total.addObject((tags == 1) ? tagString : tagString + "S") }
    if refs != 0 { total.addObject((refs == 1) ? refString : refString + "S") }
    return total.componentsJoinedByString(", ")
  }
}

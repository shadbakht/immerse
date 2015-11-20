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
  var recentlyViewedWritings : NSArray = []
  
  func setup() {
    recentlyViewedWritings = interactor!.getRecent()
    if !isSetup {
      isSetup = true
    }
  }
  
  func numberOfRecentlyViewed() -> Int {
    return recentlyViewedWritings.count
  }

  func selectCell(indexPath:NSIndexPath) {
    let row = indexPath.row
    let writing = recentlyViewedWritings.objectAtIndex(row)
    interactor!.selectWriting(writing as! Writing)
  }
  func recentlyViewedCellForIndex(tableView:UITableView, indexPath: NSIndexPath) -> HomeViewCell? {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeViewCell", forIndexPath: indexPath) as? HomeViewCell
    let row = indexPath.row
    let writing : Writing = recentlyViewedWritings.objectAtIndex(row) as! Writing
    let data = interactor!.getProgressForWriting(writing)
    let counts = interactor!.getTagNoteRefCounts(writing)
    let subtitle = createSubtitleFromCount(counts.notes, tags: counts.tags, refs: counts.refs)
    
    cell?.writingTitleLabel.text = writing.writing_title
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
    let noteString = String(format:"%d Note", notes)
    let tagString = String(format:"%d Tag", tags)
    let refString = String(format:"%d Ref", refs)
    
    if notes != 0 { total.addObject((notes == 1) ? noteString : noteString + "s") }
    if tags != 0 { total.addObject((tags == 1) ? tagString : tagString + "s") }
    if refs != 0 { total.addObject((refs == 1) ? refString : refString + "s") }
    return total.componentsJoinedByString(", ")
  }
}

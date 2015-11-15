//
//  HomeInteractor.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {

  static let sharedInstance = HomeInteractor()
  var presenter : HomePresenter? = nil
  
  func getRecent() -> NSArray {
    return DataManager.getLatestWritingsOpened(8)
  }
  
  func selectWriting(writing:Writing) {
    DataManager.selectWriting(writing.writing_filepath)
  }
  
  func getProgressForWriting(writing:Writing) -> (progress:Float, text:String) {
    let val = DataManager.getTextProgressForText(writing.writing_id)
    let percent = 100 * val
    let label = String(format: "%.1f %%", percent)
    return (val, label)
  }
  
  func getTagNoteRefCounts(writing:Writing) -> (notes:Int, tags:Int, refs:Int) {
    let notes = DataManager.getNotesForText(writing.writing_id)
    let tags = DataManager.getTagsForText(writing.writing_id)
    let refs = DataManager.getRefsForText(writing.writing_id)
    
    return (notes.count, tags.count, refs.count)
  }
  
}

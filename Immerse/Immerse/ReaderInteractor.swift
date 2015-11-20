//
//  ReaderInteractor.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ReaderInteractor: NSObject {

  static let sharedInstance : ReaderInteractor = ReaderInteractor()
  var presenter : ReaderPresenter? = nil
  
  func getCurrentBody() -> String {
    return DataManager.getCurrentBody()
  }
  
  func getCurrentNotes() -> NSArray {
    let notes = DataManager.getNotesForCurrentText()
    return notes
  }
  
  func getCurrentProgress() -> Float {
    return DataManager.getCurrentTextProgress()
  }
  
  func createNote(range:NSRange, text:String) {
    let start = range.location
    let length = range.length
    DataManager.createNoteForCurrentText(start, length:length, text:text)
  }
  
  func createTagLabel(name:String) {
    DataManager.createTagName(name)
  }
  func updateCurrentProgress(progress:Float) -> Bool {
    if progress > DataManager.getCurrentTextProgress() {
      DataManager.updateCurrentTextProgress(progress)
      return true
    } else {
      return false
    }
  }
}

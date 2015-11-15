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
  
  func createNote(range:NSRange, text:String) {
    let start = range.location
    let length = range.length
    DataManager.createNoteForCurrentText(start, length:length, text:text)
  }
}

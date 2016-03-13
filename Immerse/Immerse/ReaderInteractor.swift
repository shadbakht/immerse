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
    return ""
  }
  
  func getCurrentNotes() -> NSArray {
    let notes = []
    return notes
  }
  func getCurrentTags() -> NSArray {
    let tags = []
    return tags
  }
  func getCurrentRefs() -> NSArray {
    let refs = []
    return refs
  }
  func getCurrentProgress() -> Float {
    return 0.0
  }
  
  func createNote(range:NSRange, text:String) {
    let start = range.location
    let length = range.length
  }
  func createTag(range:NSRange, tags:NSArray) {
  }
  func createRef(writingID:String, range:NSRange, rangeSource:NSRange) {
    let start = range.location
    let length = range.length
  }
  func createTagLabel(name:String) {
  }
  
  func tagTypes() -> NSArray {
    return []
  }
  
  func updateCurrentProgress(progress:Float) -> Bool {
    return false
  }
}

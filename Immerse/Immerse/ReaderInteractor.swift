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
  func getCurrentTags() -> NSArray {
    let tags = DataManager.getTagsForCurrentText()
    return tags
  }
  func getCurrentRefs() -> NSArray {
    let refs = DataManager.getRefsForCurrentText()
    return refs
  }
  func getCurrentProgress() -> Float {
    return DataManager.getCurrentTextProgress()
  }
  
  func createNote(range:NSRange, text:String) {
    let start = range.location
    let length = range.length
    DataManager.createNoteForCurrentText(start, length:length, text:text)
  }
  func createTag(range:NSRange, tags:NSArray) {
    let tags = DataManager.tagsForNames(tags)
    for tag in tags {
      let tagObj = tag as! TagType
      let tagID = tagObj.id
      let start = range.location
      let length = range.length
      DataManager.createTagForCurrentText(start, length: length, tagID: tagID)
    }
  }
  func createRef(writingID:String, range:NSRange, rangeSource:NSRange) {
    let start = range.location
    let length = range.length
    DataManager.createRefForCurrentText(
      start, length: length, writing: writingID,
      startRef: rangeSource.location, lengthRef: rangeSource.length)
  }
  func createTagLabel(name:String) {
    DataManager.createTagName(name)
  }
  
  func tagTypes() -> NSArray {
    return DataManager.getTagTypes()
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

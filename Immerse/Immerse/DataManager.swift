//
//  DataManager.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class DataManager: NSObject {

  class func setup() {
    WritingService.setup()
    RAService.recursivelyBuildMapping()
  }
  
  class func getFolderMapping() -> NSArray {
    return RAService.mapping
  }
  
  class func getLatestWritingsOpened(count:Int) -> NSArray {
    let activities = ActivityService.getLatestWritings(count)
    let writings = WritingService.activityToWriting(activities)
    return writings
  }
  
  class func selectWriting(name:String) {
    WritingService.selectWriting(name)
    ActivityService.recordLastWriting(WritingService.current_writing_object!)
    Util.notify("ShowReader")
  }
  
  class func selectWritingForXRef(name:String) {
    WritingService.selectWritingForXRef(name)
  }
  
  class func getCurrentTextProgress() -> Float {
    return ProgressService.getProgressForText(WritingService.current_writing_object!)
  }
  
  class func getTextProgressForText(writing_id:String) -> Float {
    let writing = WritingService.writingForID(writing_id)
    return ProgressService.getProgressForText(writing!)
  }
  class func updateCurrentTextProgress(progress:Float) {
    ProgressService.createOrUpdateProgressForText(progress, text: WritingService.current_writing_object!)
  }
  
  class func childrenForPath(path:String) -> NSDictionary {
    let paths = WritingService.contentsOfSubFolder(path, isTop: WritingService.isTopLevel(path))
    if paths == nil {
      return [:]
    }
    return paths!
  }
  
  class func getCurrentBody() -> String {
    return WritingService.getCurrentBody()
  }
  
  class func getCurrentXRefBody() -> String {
    return WritingService.getCurrentXRefBody()
  }
  
  class func createNoteForCurrentText(start:Int, length:Int, text:String) {
    NotesService.createNoteForText(start, length:length,
      text:text, currentWriting: WritingService.current_writing_object!)
  }
  class func createTagForCurrentText(start:Int, length:Int, tagID:String) {
    TagService.createTagObject(start, length: length, tagID: tagID, currentWriting: WritingService.current_writing_object!)
  }
  class func createTagName(name:String) {
    TagService.createTagType(name)
  }
  
  class func tagsForNames(names:NSArray) -> NSArray {
    return TagService.tagTypesForNames(names)
  }
  class func getTagTypes() -> NSArray {
    return TagService.getTagTypes()
  }
  class func getTags() -> NSArray {
    return TagService.getTags()
  }
  class func getNotes() -> NSArray {
    return NotesService.getNotes()
  }
  class func getXRefs() -> NSArray {
    return []
  }
  class func getNotesForCurrentText() -> NSArray {
    return NotesService.getNotesForText(WritingService.current_writing_object!)
  }
  class func getTagsForCurrentText() -> NSArray {
    return TagService.getTagsForText(WritingService.current_writing_object!)
  }
  
  class func getNotesForText(writing_id:String) -> NSArray {
    let writing = WritingService.writingForID(writing_id)
    let notes = NotesService.getNotesForText(writing!)
    return notes
  }
  
  class func getTagsForText(writing_id:String) -> NSArray {
    let writing = WritingService.writingForID(writing_id)
    let tags = TagService.getTagsForText(writing!)
    return tags
  }
  
  class func getRefsForText(writing_id:String) -> NSArray {
    return []
  }
}

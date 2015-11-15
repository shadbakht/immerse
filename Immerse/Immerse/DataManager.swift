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
  class func selectWriting(name:String) {
    WritingService.selectWriting(name)
    Util.notify("ShowReader")
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
  
  class func createNoteForCurrentText(start:Int, length:Int, text:String) {
    NotesService.createNoteForText(start, length:length,
      text:text, currentWriting: WritingService.current_writing_object!)
  }
  
  class func getNotesForCurrentText() -> NSArray {
    return NotesService.getNotesForText(WritingService.current_writing_object!)
  }
}

//
//  Record.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

enum RecordType : String {
  case CHAPTER = "chapter"
  case PARAGRAPH = "paragraph"
  case SECTION = "section"
}

class RecordInterface : GenericModelInterface {
  static let sharedInstance = RecordInterface()
  func getRecordTree() -> NSArray {
    return []
  }
}

class Record: Object {

  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = ""
  dynamic var faith : Faith?
  dynamic var author : Author?
  dynamic var book : Book?
  dynamic var record_type : RecordType.RawValue = ""
  dynamic var record_typeCount : Int = 0
  dynamic var record_text : String = ""
  dynamic var record_textCount : Int = 0

  var tags: [Tag] {
    return linkingObjects(Tag.self, forProperty: "record")
  }
  var notes: [Note] {
    return linkingObjects(Note.self, forProperty: "record")
  }
  var refs : [CrossRef] {
    let source = linkingObjects(CrossRef.self, forProperty: "source_ref")
    let destination = linkingObjects(CrossRef.self, forProperty: "destination_ref")
    var new : [CrossRef] = []
    new.appendContentsOf(source)
    new.appendContentsOf(destination)
    return new
  }
  
  
  

}

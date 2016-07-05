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

  var tags : [Tag] = Array(LinkingObjects(fromType: Tag.self, property: "record"))
  var notes : [Note] = Array(LinkingObjects(fromType: Note.self, property: "record"))

  var refs : [CrossRef] {
    let source = Array(LinkingObjects(fromType:CrossRef.self, property: "source_ref"))
    let destination = Array(LinkingObjects(fromType:CrossRef.self, property: "destination_ref"))
    var new : [CrossRef] = []
    new.appendContentsOf(source)
    new.appendContentsOf(destination)
    return new
  }
  
  
  

}

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

class Record: Object {

  override static func primaryKey() -> String? {
    return "id"
  }
  
  dynamic var id = 0
  dynamic var record_faithName : String = ""
  dynamic var record_authorName : String = ""
  dynamic var record_bookName : String = ""
  dynamic var type : RecordType.RawValue = ""
  dynamic var typeCount : Int = 0
  dynamic var text : String = ""
  dynamic var textCount : Int = 0
}

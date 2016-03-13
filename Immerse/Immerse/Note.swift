//
//  Note.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class NoteInterface : NSObject {
  
}
class Note: Object {

  dynamic var id : String = ""
  dynamic var record : Record?
  dynamic var start_position : Int = 0
  dynamic var length : Int = 0
  dynamic var note_comment : String = ""
  dynamic var creation_date : NSDate = NSDate()
  
}

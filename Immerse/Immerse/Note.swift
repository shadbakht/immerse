//
//  Note.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class Note: Object {

  dynamic var note_id : String = ""
  dynamic var writing_id : String = ""
  dynamic var start_position : Int = 0
  dynamic var end_position : Int = 0
  dynamic var note_comment : String = ""
  
}

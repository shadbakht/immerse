//
//  CrossRef.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class CrossRef: Object {
    
  dynamic var xref_id : String = ""
  dynamic var writing_id_start : String = ""
  dynamic var writing_id_end : String = ""
  dynamic var start_writing : Int = 0
  dynamic var length_writing : Int = 0
  dynamic var start_reference : Int = 0
  dynamic var length_reference : Int = 0

}

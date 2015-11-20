//
//  Tag.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class TagTypes : Object {
  dynamic var tag_type_id : String = ""
  dynamic var tag_type_name : String = ""
  dynamic var tag_parent_id : String = ""
}

class Tag: Object {
    
  dynamic var tag_id : String = ""
  dynamic var tag_type_id : String = ""
  dynamic var writing_id : String = ""
  dynamic var start_position : Int = 0
  dynamic var length : Int = 0

}

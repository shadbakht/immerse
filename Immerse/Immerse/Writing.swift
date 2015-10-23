//
//  Writing.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class Writing: Object {
  
  dynamic var writing_id : String = ""
  dynamic var writing_title : String = ""
  dynamic var writing_author : String = ""
  dynamic var writing_category : String = ""
  dynamic var writing_filepath : String = ""
  dynamic var writing_paragraph_count : Int = 0
}

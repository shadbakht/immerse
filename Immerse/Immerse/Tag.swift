//
//  Tag.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class TagTypeInterface : GenericModelInterface {
  
}

class TagType : Object {

  dynamic var id : String = ""
  dynamic var name : String = ""
  dynamic var parent : TagType?
}


class TagInterface : GenericModelInterface {
  
}

class Tag: Object {
  
  dynamic var id : String = ""
  dynamic var type : TagType?
  dynamic var record : Record?
  dynamic var start_position : Int = 0
  dynamic var length : Int = 0
  
}

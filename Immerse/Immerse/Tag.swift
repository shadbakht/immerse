//
//  Tag.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class TagTypeInterface : GenericModelInterface {
  class func createTag(name:String) -> Bool {
    let tag = TagType()
    tag.name = name
    tag.id = name.sha1()
    RealmService.createObject(tag)
    return true
  }
  
  class func getAllTagTypes() -> [TagType] {
    return RealmService.allObjects(TagType.self) as! [TagType]
  }

}

class TagType : Object {

  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = ""
  dynamic var name : String = ""
  dynamic var parent : TagType?
}


class TagInterface : GenericModelInterface {
  
}

class Tag: Object {
  
  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = ""
  dynamic var type : TagType?
  dynamic var record : Record?
  dynamic var start_position : Int = 0
  dynamic var length : Int = 0
  
}

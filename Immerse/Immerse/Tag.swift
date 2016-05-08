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

  dynamic var id : String = String.unique()
  dynamic var name : String = ""
  dynamic var parent : TagType?
  
  var tags: [Tag] {
    return linkingObjects(Tag.self, forProperty: "type")
  }

}


class TagInterface : GenericModelInterface {
  class func createTag(record:Record, range:NSRange, type:TagType) {
    let tag = Tag()
    tag.record = record
    tag.start_position = range.location
    tag.length = range.length
    tag.type = type
    RealmService.createObject(tag)
  }
}

class Tag: Object {
  
  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = String.unique()
  dynamic var type : TagType?
  dynamic var record : Record?
  dynamic var start_position : Int = 0
  dynamic var length : Int = 0
  dynamic var creation_date : NSDate = NSDate()
  
}

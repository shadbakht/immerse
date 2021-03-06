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
  
  class func deleteTagType(tagType:TagType? = nil) {
    if tagType == nil {
      let types = getAllTagTypes()
      RealmService.deleteObjects(types)
    } else {
      RealmService.deleteObject(tagType!)
    }
  }
  
}

class TagType : Object {

  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = String.unique()
  dynamic var name : String = ""
  dynamic var parent : TagType?
  
  var tags : [Tag] = Array(LinkingObjects(fromType: Tag.self, property: "type"))

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
  
  class func getAllTags() -> [Tag] {
    return RealmService.allObjects(Tag.self) as! [Tag]
  }
  
  class func deleteTag(tag:Tag? = nil) {
    if let t = tag {
      RealmService.deleteObject(t)
    }
  }
  
  class func deleteTagsOfType(type:TagType?=nil) {
    if type == nil {
      RealmService.deleteObjects(getAllTags())
      return
    }
    let objs = RealmService.allObjects(Tag).filter({
      let tag = $0 as! Tag
      return tag.type == type
    })
    RealmService.deleteObjects(objs)
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
  
  var recordText : String {
    get {
      let text = record!.record_text as NSString
      let range = NSMakeRange(start_position, length)
      return text.substringWithRange(range)
    }
  }
  
  var shareText : String {
    get {
      return recordText
    }
  }
}

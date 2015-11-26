//
//  TagService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class TagService: NSObject {

  class func tagTypes() -> NSArray {
    return []
  }
  
  class func tagTypeCounts(tagID:String) -> Int {
    return 0
  }
  
  class func getTagsForText(currentWriting:Writing) -> NSArray {
    let writing_id = currentWriting.writing_id
    let results = RealmService.objectsForQuery(Tag.self, query: "writing_id = '" + writing_id + "'")
    return results
  }
  
  class func createTagType(name:String) {
    let type = TagTypes()
    type.tag_type_name = name
    type.tag_parent_id = ""
    type.tag_type_id = Util.uniqueString()
    RealmService.createObject(type)
  }
  
  class func getTagTypes() -> NSArray {
    return RealmService.allObjectsForType(TagTypes.self)
  }
  class func getTags() -> NSArray {
    return RealmService.allObjectsForType(Tag.self)
  }
  
  class func tagTypesForNames(names:NSArray) -> NSArray {
    let mutableResults : NSMutableArray = []
    for name in names {
      let nameString = (name as! String)
      let results = RealmService.objectsForQuery(TagTypes.self, query: "tag_type_name = '" + nameString + "'")
      if results.count > 0 { mutableResults.addObject(results.firstObject!) }
    }
    return mutableResults
  }
  class func createTagObject(start:Int, length:Int, tagID:String, currentWriting:Writing) {
    let tagObj = Tag()
    tagObj.tag_id = Util.uniqueString()
    tagObj.start_position = start
    tagObj.length = length
    tagObj.tag_type_id = tagID
    tagObj.writing_id = currentWriting.writing_id
    RealmService.createObject(tagObj)
  }
  
}

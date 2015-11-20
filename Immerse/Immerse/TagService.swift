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
  class func createTagObject(start:Int, end:Int, tagID:String, writingID:String) {
    
  }
  
}

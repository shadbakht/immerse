//
//  CrossRefService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class CrossRefService: NSObject {

  class func getRefs() -> NSArray {
    return RealmService.allObjectsForType(CrossRef.self)
  }
  
  class func createRefForText(
    startWriting:Int, lengthWriting:Int, writing:Writing,
    startReference:Int, lengthReference:Int, reference:Writing
    )
  {
    let obj = CrossRef()
    obj.start_writing = startWriting
    obj.length_writing = lengthWriting
    obj.start_reference = startReference
    obj.length_reference = lengthReference
    obj.writing_id_start = writing.writing_id
    obj.writing_id_end = reference.writing_id
    
    RealmService.createObject(obj)
  }
  
  class func getRefsForText(writing:Writing) -> NSArray {
    let writing_id = writing.writing_id
    let results = RealmService.objectsForQuery(CrossRef.self, query:
      "writing_id_start = '" + writing_id + "' OR writing_id_end = '" + writing_id + "'")
    return results

  }
}

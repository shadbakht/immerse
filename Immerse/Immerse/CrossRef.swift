//
//  CrossRef.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class CrossRefInterface : GenericModelInterface {
  class func createCrossRef(src:Record, srcRange:NSRange, dest:Record, destRange:NSRange) {
    let cross = CrossRef()
    cross.source_ref = src
    cross.source_index = srcRange.location
    cross.source_length = srcRange.length
    cross.destination_ref = dest
    cross.destination_index = destRange.location
    cross.destination_length = destRange.length
    RealmService.createObject(cross)
  }
  
  class func getAllCrossRefs() -> [CrossRef] {
    return RealmService.allObjects(CrossRef.self) as! [CrossRef]
  }
  
  class func deleteCrossRef(crossRef:CrossRef) {
    RealmService.deleteObject(crossRef)
  }
  
  class func deleteAllCrossRef() {
    let objects = getAllCrossRefs()
    RealmService.deleteObjects(objects)
  }

}

class CrossRef: Object {

  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = String.unique()
  dynamic var source_ref : Record?
  dynamic var destination_ref : Record?
  dynamic var source_index : Int = 0
  dynamic var source_length : Int = 0
  dynamic var destination_index : Int = 0
  dynamic var destination_length : Int = 0
  dynamic var creation_date : NSDate = NSDate()

  var sourceText : String {
    get {
      let text = source_ref!.record_text as NSString
      let range = NSMakeRange(source_index, source_length)
      return text.substringWithRange(range)
    }
  }
  
  var destinationText : String {
    get {
      let text = destination_ref!.record_text as NSString
      let range = NSMakeRange(destination_index, destination_length)
      return text.substringWithRange(range)
    }
  }

}

//
//  Faith.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

extension Object {
  static func primaryKey() -> String? {
    return "id"
  }
}

class GenericModelInterface : NSObject {
  
  class func getObjectsBy<T>(type:T, name:String, value:AnyObject) -> [Object] {
    var query = "\(name) == \(value)"
    if value is String {
      query = "\(name) == '\(value)'"
    }
    return RealmService.objectsWhere(type, query: query )
  }
  
}



class FaithInterface : GenericModelInterface {
  
  class func getAllFaiths() -> [Faith] {
    return RealmService.allObjects(Faith.self) as! [Faith]
  }
  
}

class Faith: Object {
  
  dynamic var id : String = ""
  dynamic var name : String = ""
  
  var authors: [Author] {
    return linkingObjects(Author.self, forProperty: "faith")
  }
  
  var records : [Record] {
    return linkingObjects(Record.self, forProperty: "author")
  }
}

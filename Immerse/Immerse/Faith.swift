//
//  Faith.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class FaithInterface : GenericModelInterface {
  
  class func getAllFaiths() -> [Faith] {
    return RealmService.allObjects(Faith.self) as! [Faith]
  }
  
  class func getFaithBy(identifier:String, value:String) -> [Faith] {
    
    let query =  NSString(format: "%@ = '%@'", identifier, value)
    do {
      if let realm = try? Realm() {
        let results = realm.objects(Faith).filter(query as String)
        print(results.count)
      }
    }
    
    let result = RealmService.objectsWhere(Faith.self, query:query as String)
    return result as! [Faith]
  }
}

class Faith: Object {
  
  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = ""
  dynamic var name : String = ""
  
  var authors: [Author] {
    return linkingObjects(Author.self, forProperty: "faith")
  }
  
  var records : [Record] {
    return linkingObjects(Record.self, forProperty: "author")
  }
  
  var books : [Book] {
    return linkingObjects(Book.self, forProperty: "faith")
  }
  
  static func getAllFaiths() -> [Faith] {
    do {
      let realm = try Realm()
      let results = realm.objects(Faith).map({$0})
      return results
    } catch let error {
      print(error)
      return[]
    }
  }
  
}

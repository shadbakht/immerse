//
//  Author.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class AuthorInterface : GenericModelInterface {
  
  class func getAuthors(faith:Faith? = nil) -> [Author] {
    if faith == nil {
      return RealmService.allObjects(Author.self) as! [Author]
    } else {
      return faith!.authors
    }
  }
}

class Author: Object {
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  dynamic var id : String = ""
  dynamic var name : String = ""
  dynamic var faith : Faith?
  
  let books : [Book] = Array(LinkingObjects(fromType: Book.self, property: "author"))
  let records : [Record] = Array(LinkingObjects(fromType: Record.self, property: "author"))  
}

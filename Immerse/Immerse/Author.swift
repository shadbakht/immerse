//
//  Author.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class Author: Object {
  dynamic var id : String = ""
  dynamic var name : String = ""
  dynamic var faith : Faith?
  
  var books: [Book] {
    return linkingObjects(Book.self, forProperty: "author")
  }
  
  var records : [Record] {
    return linkingObjects(Record.self, forProperty: "author")
  }
}

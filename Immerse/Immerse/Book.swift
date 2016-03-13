//
//  Book.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class Book : Object {
  
  dynamic var book_id : String
  dynamic var book_name : String
  dynamic var author : Author?

  var records: [Record] {
    return linkingObjects(Record.self, forProperty: "book")
  }

}

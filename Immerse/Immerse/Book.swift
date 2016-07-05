//
//  Book.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class BookInterface : GenericModelInterface {
  
  class func getBooks(author:Author? = nil) -> [Book] {
    if author == nil {
      return RealmService.allObjects(Book.self) as! [Book]
    } else {
      return author!.books
    }
  }
}

class Book : Object {

  override static func primaryKey() -> String? {
    return "id"
  }

  dynamic var id : String = ""
  dynamic var name : String = ""
  dynamic var author : Author?
  dynamic var faith : Faith?
  
  var records: [Record] {
    // Ensure that records is in order
    let records = LinkingObjects(fromType:Record.self, property: "book")
    return records.sort({ recordsTuple in
      return recordsTuple.0.record_textCount < recordsTuple.1.record_textCount
    })
  }

}

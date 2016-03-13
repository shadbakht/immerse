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
  
  dynamic var book_id : String = ""
  dynamic var book_name : String = ""
  dynamic var author : Author?

  var records: [Record] {
    return linkingObjects(Record.self, forProperty: "book")
  }

}

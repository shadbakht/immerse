//
//  Faith.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class Faith: Object {
  dynamic var id : String = ""
  dynamic var name : String = ""
  
  var authors: [Author] {
    return linkingObjects(Author.self, forProperty: "faith")
  }
  

}

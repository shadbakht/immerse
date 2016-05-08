//
//  Progress.swift
//  Immerse
//
//  Created by James Tan on 5/8/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift


class ProgressInterface : GenericModelInterface {
}

class Progress: Object {
  override static func primaryKey() -> String? {
    return "id"
  }
  
  dynamic var id : String = String.unique()
  dynamic var writing : Book?
  dynamic var row : Int = 0
  dynamic var creation_date : NSDate = NSDate()
}

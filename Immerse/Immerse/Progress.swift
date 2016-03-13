//
//  Progress.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class Progress: Object {

  dynamic var id : String = ""
  dynamic var record : Record?
  dynamic var progress : Float = 0.0
  dynamic var lastOpened : NSDate = NSDate()
  
}

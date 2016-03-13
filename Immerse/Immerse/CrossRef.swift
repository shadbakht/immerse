//
//  CrossRef.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import RealmSwift

class CrossRefInterface : NSObject {
  
}

class CrossRef: Object {

  dynamic var id : String = ""
  dynamic var source_ref : Record?
  dynamic var destination_red : Record?
  dynamic var source_index : Int = 0
  dynamic var source_length : Int = 0
  dynamic var destination_index : Int = 0
  dynamic var destination_length : Int = 0

}

//
//  CrossRefService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class CrossRefService: NSObject {

  class func createRefForText(start:Int, length:Int, writing:Writing, reference:Writing) {
    let obj = CrossRef()
    obj.start_position = start
    obj.length = length
    obj.writing_id_start = writing.writing_id
    obj.writing_id_end = reference.writing_id
    RealmService.createObject(obj)
  }
}

//
//  RealmService.swift
//  Immerse
//
//  Created by James Tan on 10/22/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RealmSwift
class RealmService: NSObject {

  class func objectsForQuery(objectType:AnyObject.Type, query : String) -> NSArray {
//    // TO REFACTOR
//    let realm = Realm()
//    var results = realm.objects(objectType as! Object).filter(query)
//    return (results.valueForKey("self") as! NSArray)
    return []
  }

}

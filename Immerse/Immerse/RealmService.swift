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

  class func numberOfObjectsOfType(objectType:AnyObject.Type) -> Int {
    let realm = try! Realm()
    if objectType == Writing.self {
      return realm.objects(Writing).count
    }
    
    return 0
  }
  
  class func createObject(object:AnyObject) {
    
    let realm = try! Realm()
    
    // Create Writing
    if object is Writing {
      try! realm.write({
        realm.add(object as! Writing)
      })
    }
    
    // Create Note
    if object is Note {
      try! realm.write({
        realm.add(object as! Note)
      })
    }
    
    // Create Activity
    if object is Activity {
      try! realm.write({
        realm.add(object as! Activity)
      })
    }
    
  }
  
  class func allObjectsForType(objectType:AnyObject.Type) -> NSArray {
    
    let realm = try! Realm()
    
    if objectType == Writing.self {
      let results = realm.objects(Writing)
      return (results.valueForKey("self") as! NSArray)
    }
    if objectType == Note.self {
      let results = realm.objects(Note)
      return (results.valueForKey("self") as! NSArray)
    }
    if objectType == Activity.self{
      let results = realm.objects(Activity)
      return (results.valueForKey("self") as! NSArray)

    }
    return []
  }

  class func objectsForQuery(objectType:AnyObject.Type, query : String) -> NSArray {
    
    let realm = try! Realm()
    
    if objectType == Writing.self {
      let results = realm.objects(Writing).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }
    
    if objectType == Note.self {
      let results = realm.objects(Note).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }
    
    if objectType == Activity.self {
      let results = realm.objects(Activity).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }
    
    return []
  }
}

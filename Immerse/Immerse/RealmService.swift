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
    
    // Create Activity
    if object is Progress {
      try! realm.write({
        realm.add(object as! Progress)
      })
    }
    
    // Create TagTypes
    if object is TagTypes {
      try! realm.write({
        realm.add(object as! TagTypes)
      })
    }

    // Create TagTypes
    if object is Tag {
      try! realm.write({
        realm.add(object as! Tag)
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
    if objectType == Progress.self{
      let results = realm.objects(Progress)
      return (results.valueForKey("self") as! NSArray)
    }
    if objectType == TagTypes.self{
      let results = realm.objects(TagTypes)
      return (results.valueForKey("self") as! NSArray)
    }
    if objectType == Tag.self{
      let results = realm.objects(Tag)
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
    
    if objectType == Progress.self {
      let results = realm.objects(Progress).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }
    
    if objectType == TagTypes.self {
      let results = realm.objects(TagTypes).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }

    if objectType == Tag.self {
      let results = realm.objects(Tag).filter(query)
      return (results.valueForKey("self") as! NSArray)
    }

    return []
  }
  
  class func updateObject(objectType:AnyObject.Type, keyIdentify : String, keyValue: String, keys: NSArray, values: NSArray) {

    let realm = try! Realm()

    if objectType == Progress.self {
      let progress : Progress = objectsForQuery(Progress.self, query: keyIdentify + " = '" + keyValue + "'").firstObject as! Progress
      let properties = NSDictionary(objects: values as [AnyObject], forKeys: keys as! [NSCopying])
      try! realm.write({
        progress.setValuesForKeysWithDictionary(properties as! [String : AnyObject])
      })

    }
  }

}

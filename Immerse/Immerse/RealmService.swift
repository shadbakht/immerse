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

  
  class func numberOfObjects<T>(type:T) -> Int {
    do {
      if let realm = try? Realm() {
        if let typeCheck = type as? Object.Type {
          return realm.objects(typeCheck).count
        }
      }
    }
    return 0
  }
  
  class func createObject<T>(object:T) {
    do {
      if let realm = try? Realm() {
        _ = try? realm.write {
          realm.add(object as! Object)
        }
      }
    }
  }

  class func allObjects<T>(type:T) -> [Object] {
    do {
      if let realm = try? Realm() {
        if let typeCheck = type as? Object.Type {
          if let results = realm.objects(typeCheck).valueForKey("self") as? [Object] {
            return results
          }
        }
      }
    }
    return []
  }

  class func objectsWhere<T>(type:T, query : String) -> [Object] {
    do {
      if let realm = try? Realm() {
        if let typeCheck = type as? Object.Type {
          if let results = realm.objects(typeCheck).filter(query).valueForKey("self") as? [Object] {
            return results
          }
        }
      }
    }
    return []
  }
  
  class func updateObject<T>(type:T,pid:String, keys:[String], values:[AnyObject]) {
    do {
      if let realm = try? Realm(), typeCheck = type as? Object.Type {
        if let object = objectsWhere(typeCheck, query: "id = '\(pid)'").first {
          let properties = NSDictionary(objects: values, forKeys: keys)
          _ = try? realm.write {
            object.setValuesForKeysWithDictionary(properties as! [String : AnyObject])
          }
        }
      }
    }
  }
  
  class func deleteObject(object:Object) {
    if let realm = try? Realm () {
      do {
        try! realm.write {
          realm.delete(object)
        }
      }
    }
  }

  
}

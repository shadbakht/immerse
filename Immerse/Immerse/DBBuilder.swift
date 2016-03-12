//
//  DBBuilder.swift
//  Immerse
//
//  Created by James Tan on 3/12/16.
//  Copyright © 2016 Immerse. All rights reserved.
//
//  DBBuilder: This class should only be executed when building a debug version 
//  of the application. This will generate a realm file on the desktop at the assigned
//  path. It will process folders at a set path as well, also located on the user
//  machine.

import UIKit
import RealmSwift

class DBBuilder: NSObject {

  func processFromFilePath(path:String) {
    
    let testRecordSampe = "KEY|test faith| test author| this is a book|3|chapter|1|this is some awesome text"
    let pathRealm :String = "/Users/jamestan/Desktop/output.realm"
    
    let config = setupRealm(pathRealm)
    processRow(testRecordSampe, config: config)
  }

  func setupRealm(path:String) -> Realm.Configuration {
    var config = Realm.Configuration()
    config.path = path
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
      if (oldSchemaVersion < 1) {
      }
    }
    //  let config = Realm.Configuration(path: realmPath, schemaVersion: 2, migrationBlock: migrationBlock )
    config.migrationBlock = migrationBlock
    config.schemaVersion = 2
    return config
  }
  

  func processRow(row:String, config:Realm.Configuration) -> Bool {
    
    let keys = ["id","record_faithName","record_authorName","record_bookName","record_typeCount", "record_type","record_textCount","record_text"]
    let values = row.componentsSeparatedByString("|")
    let properties = NSMutableDictionary(objects: values, forKeys: keys)
    
    // Fix the Properties
    properties.setObject((properties.objectForKey("record_textCount")?.integerValue)!, forKey: "record_textCount")
    properties.setObject((properties.objectForKey("record_typeCount")?.integerValue)!, forKey: "record_typeCount")
    let propertiesFinal = NSDictionary(objects: properties.allValues, forKeys: properties.allKeys as! [NSCopying])
    
    let recordObj = Record()
    recordObj.setValuesForKeysWithDictionary((propertiesFinal as? [String : AnyObject])!)
    
    // Create a Realm Object
    do {
      let realm = try! Realm(configuration: config)
      try! realm.write({
        realm.add(recordObj)
      })
      return true
    }
  }

}

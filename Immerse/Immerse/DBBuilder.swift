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

  /**
   processFromeFilePath
   Pass in a file path, get out a db realm to your desktop
   - parameter path: String
   - parameter out:  String : desktop path + realm name
   */
  func processFromFilePath(path:String, out:String="/Users/jamestan/Desktop/default.realm") {
    let testRecordSampe = "test faith| test author| this is a book|3|chapter|1|this is some awesome text"
    let config = setupRealm(out)
    processRow(testRecordSampe, config: config)
  }

  /**
   setupRealm
   Configures a Realm configuration file to use in writing to the Realm DB on your
   Desktop
   - parameter path: String : path to realm to save
   - returns: Realm.Configuration : a configuration file for your realm DB
   */
  func setupRealm(path:String) -> Realm.Configuration {
    var config = Realm.Configuration()
    config.path = path
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
      if (oldSchemaVersion < 1) {
      }
    }
    config.migrationBlock = migrationBlock
    config.schemaVersion = 2
    return config
  }
  
  /**
   processRow
   Processes an individual record and writes it to the database and configured
   In the Realm.Configuration file.
   - parameter row:    String : bar dilimited string
   - parameter config: Realm.Configuration : from setupRealm
   - returns: Bool : Success?
   */
  func processRow(row:String, config:Realm.Configuration) -> Bool {
    
    let keys = ["record_faithName","record_authorName","record_bookName","record_typeCount", "record_type","record_textCount","record_text"]
    let values = row.componentsSeparatedByString("|")
    let properties = NSMutableDictionary(objects: values, forKeys: keys)
    
    // Add a Unique ID
    properties.setObject(NSDate().description.sha1(), forKey: "id")
    
    // Fix the Properties
    properties.setObject((properties.objectForKey("record_textCount")?.integerValue)!, forKey: "record_textCount")
    properties.setObject((properties.objectForKey("record_typeCount")?.integerValue)!, forKey: "record_typeCount")
    let propertiesFinal = NSDictionary(objects: properties.allValues, forKeys: properties.allKeys as! [NSCopying])
    
    // Create Faith
    var faithObj = Faith()
    let name = propertiesFinal.valueForKey("record_faithName") as! String
    let results = FaithInterface.getObjectsBy(Faith.self, name: "name", value: name)
    if results.count == 1 {
      faithObj = results.first as! Faith
    } else if results.count == 0 {
      faithObj.name = propertiesFinal.valueForKey("record_faithName") as! String
      faithObj.id = name.sha1()
    } else {
      print("ERROR!")
    }

    var authorObj = Author()
    let nameA = propertiesFinal.valueForKey("record_authorName") as! String
    let resultsA = AuthorInterface.getObjectsBy(Author.self, name: "name", value: name)
    if results.count == 1 {
      authorObj = resultsA.first as! Author
    } else if results.count == 0 {
      authorObj.name = nameA
      authorObj.id = nameA.sha1()
    } else {
      print("ERROR!")
    }
    
    var bookObj = Book()
    let nameB = propertiesFinal.valueForKey("record_bookName") as! String
    let resultsB = BookInterface.getObjectsBy(Book.self, name: "name", value: name)
    if results.count == 1 {
      bookObj = resultsB.first as! Book
    } else if results.count == 0 {
      bookObj.name = nameB
      bookObj.id = nameB.sha1()
    } else {
      print("ERROR!")
    }

    
    let recordObj = Record()
    recordObj.faith = faithObj
    recordObj.author = authorObj
    recordObj.book = bookObj
    recordObj.record_text = propertiesFinal.valueForKey("record_text") as! String
    recordObj.record_textCount = propertiesFinal.valueForKey("record_textCount") as! Int
    recordObj.record_type = propertiesFinal.valueForKey("record_type") as! String
    recordObj.record_typeCount = propertiesFinal.valueForKey("record_typeCount") as! Int
    recordObj.id = recordObj.record_text.sha1()
    
    authorObj.faith = faithObj
    bookObj.author = authorObj
    

    
    // Create a Realm Object
    do {
      let realm = try! Realm(configuration: config)
      try! realm.write({
        realm.add(faithObj)
        realm.add(authorObj)
        realm.add(bookObj)
        realm.add(recordObj)
        
      })
      return true
    }
  }
  
}

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
  func processFromFilePath(path:String="/Users/jamestan/Documents/immerse/Writings/", out:String="/Users/jamestan/Desktop/default.realm") {

    let config = setupRealm(out)

    if let url = NSURL(string: path) {
      do {
        let mgr = NSFileManager.defaultManager()
        var contents = try! mgr.contentsOfDirectoryAtPath(path)
        contents.removeObject(".DS_Store")
        var count = 0
        _ = contents.map({
          // Full Name
          let name = $0
          let fullPath = path + name
          count += 1
          print(count)
          print(fullPath)
          if let data = mgr.contentsAtPath(fullPath) {
            print("dataPresent")
            if let contents = NSString(data: data, encoding: NSUTF8StringEncoding) {
              print("contentsPresent")
              let contentsList = contents.componentsSeparatedByString("\n")
              _ = contentsList.map({
                processRow($0, config: config)
              })
            }
          }
        })
      } catch let error {
        let filename = "testWritings"
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "txt") {
          do {
            let test = try String(contentsOfFile: path)
            _ = test.componentsSeparatedByString("\n").map({
              processRow($0, config: config)
              print("Processing...")
            })
            print("Finished!")
          } catch let error {
            print(error)
          }
          
        }
        print(error)
      }
    }
  }

  /**
   setupRealm
   Configures a Realm configuration file to use in writing to the Realm DB on your
   Desktop
   - parameter path: String : path to realm to save
   - returns: Realm.Configuration : a configuration file for your realm DB
   */
  private func setupRealm(path:String) -> Realm.Configuration {
    var config = Realm.Configuration()
    config.path = path
    
    let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
      if (oldSchemaVersion < 1) {
      }
    }
    config.migrationBlock = migrationBlock
    config.schemaVersion = 0
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
  private func processRow(row:String, config:Realm.Configuration) -> Bool {
    
    
    // Create a Realm Object
    do {
      let realm = try! Realm(configuration: config)
      
      let keys = ["record_faithName","record_authorName","record_bookName","record_typeCount", "record_type","record_textCount","record_text"]
      let values = row.componentsSeparatedByString("|")
      
      if keys.count != values.count {
        print("ERROR")
        return false
      }
      let properties = NSMutableDictionary(objects: values, forKeys: keys)
      
      // Add a Unique ID
      properties.setObject(NSDate().description.sha1(), forKey: "id")
      
      // Fix the Properties
      properties.setObject((properties.objectForKey("record_textCount")?.integerValue)!, forKey: "record_textCount")
      properties.setObject((properties.objectForKey("record_typeCount")?.integerValue)!, forKey: "record_typeCount")
      let propertiesFinal = NSDictionary(objects: properties.allValues, forKeys: properties.allKeys as! [NSCopying])
      
      
      // NOTE: We must do all the parsing here because this Realm File is NOT referenced in the rest of the application.
      // If we try to use the app's utility methods to retrieve and process Realm DB results, this will fail!
      do {
        try realm.write({
          
          // Create Faith
          var faithObj = Faith()
          var name = propertiesFinal.valueForKey("record_faithName") as! String
          if name.containsString("'") {
            name = name.stringByReplacingOccurrencesOfString("'", withString: "")
          }
          
          let createFaith = realm.objects(Faith).filter("name = '\(name)'").count == 0
          if createFaith {
            faithObj.name = propertiesFinal.valueForKey("record_faithName") as! String
            faithObj.id = name.sha1()
          } else {
            faithObj = realm.objects(Faith).filter("name = '\(name)'").first!
          }
          
          var authorObj = Author()
          let nameA = propertiesFinal.valueForKey("record_authorName") as! String
          let createAuthor = realm.objects(Author).filter("name = '\(nameA)'").count == 0
          if createAuthor {
            authorObj.name = nameA
            authorObj.id = nameA.sha1()
          } else {
            authorObj = realm.objects(Author).filter("name = '\(nameA)'").first!
          }
          
          var bookObj = Book()
          let nameB = propertiesFinal.valueForKey("record_bookName") as! String
          let createBook = realm.objects(Book).filter("name = '\(nameB)'").count == 0
          if createBook {
            bookObj.name = nameB
            bookObj.id = nameB.sha1()
          } else {
            bookObj = realm.objects(Book).filter("name = '\(nameB)'").first!
          }
          
          
          let recordObj = Record()
          let textId = (propertiesFinal.valueForKey("record_text") as! String).sha1()
          let createRecord = realm.objects(Record).filter("id = '\(textId)'").count == 0
          if createRecord {
            recordObj.faith = faithObj
            recordObj.author = authorObj
            recordObj.book = bookObj
            recordObj.record_text = propertiesFinal.valueForKey("record_text") as! String
            recordObj.record_textCount = propertiesFinal.valueForKey("record_textCount") as! Int
            recordObj.record_type = propertiesFinal.valueForKey("record_type") as! String
            recordObj.record_typeCount = propertiesFinal.valueForKey("record_typeCount") as! Int
            recordObj.id = textId
            
            authorObj.faith = faithObj
            bookObj.author = authorObj
            bookObj.faith = faithObj
          }
          
          
          if createFaith {
            realm.add(faithObj)
          }
          if createAuthor {
            realm.add(authorObj)
          }
          if createBook {
            realm.add(bookObj)
          }
          if createRecord{
            realm.add(recordObj)
          }
          
        })

      } catch {
        print("ERROR!")
      }
      return true
    }
  }
  
}

//
//  WritingService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class WritingService: NSObject {

  static var current_writing : String = ""
  static var current_writing_object : Writing? = nil
  static var current_writing_xref_object : Writing? = nil
  static var folderMapping : NSDictionary? = nil
  
  class func setup() {
    /**
     setup
     */
    processWritings()

  }
  
  class func activityToWriting(array:NSArray) -> NSArray {
    let writingObjects : NSMutableArray = []
    for item in array {
      let itemAct : Activity = item as! Activity
      let id : String = itemAct.writing_id
      let writing = writingForID(id)
      writingObjects.addObject(writing!)
    }
    return writingObjects
  }
  
  class func writingForID(id:String) -> Writing? {
    let results = RealmService.objectsForQuery(Writing.self, query: "writing_id = '" + id + "'")
    if results.count > 0 {
      return results.firstObject as? Writing
    }
    return nil
  }
  
  class func getFolderMapping() -> NSDictionary {
    if WritingService.folderMapping == nil {
      let filePath = NSBundle.mainBundle().pathForResource("Library", ofType: "plist")
      let dictionary = NSDictionary(contentsOfFile: filePath!)
      WritingService.folderMapping = dictionary
    }
    return WritingService.folderMapping!
  }
  
  class func topLevelFolders() -> NSArray {
    let names : NSMutableArray = []
    
    // Get the top level folders
    let path = NSBundle.mainBundle().resourcePath!
    let contents = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(path)
    for item in contents {
      let items = item.componentsSeparatedByString(" - ")
      if items.count == 2 {
        let castedName =  NSString(string:items.first!)
        if castedName.integerValue < 9 && castedName.integerValue > 0 {
          names.addObject(item)
        }
      }
    }
    
    return NSArray(array: names)
  }
  
  class func isTopLevel(path:String) -> Bool {
    if path.hasPrefix(NSFileManager.localPath()) {
      return false
    } else {
      return true
    }
  }
  
  class func contentsOfSubFolder(folder:String, isTop:Bool = false) -> NSDictionary? {
    
    // Get the Directory
    var folderPath = folder
    if isTop { // If is top level then append the correct path
      folderPath = NSFileManager.localPathForItem(folder)
    }
    
    // Get the Contents of the Folder
    let contents = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(folderPath)
    if contents.count > 0 {
      
      // Get the Keys
      let keys : NSMutableDictionary = [:]
      for item in contents {
        let itemString = NSString(string: item)
        let itemNameKey = itemString.lastPathComponent.stringByReplacingOccurrencesOfString(".txt", withString: "")
        keys[itemNameKey] = item
      }
      
      return keys
    }
    
    return nil
  }
  
  class func selectWriting(name:String) {
    var nameCleaned = name
    if name.containsString("'") {
      nameCleaned = name.componentsSeparatedByString("/").last!
    }
    WritingService.current_writing = name
    let query = "writing_filepath CONTAINS '" + nameCleaned + "'"
    let results = RealmService.objectsForQuery(Writing.self, query: query)
    WritingService.current_writing_object = (results.firstObject as! Writing) // @jtan: TODO: Just for now
  }
  
  class func selectWritingForXRef(name:String) {
    var nameCleaned = name
    if name.containsString("'") {
      nameCleaned = name.componentsSeparatedByString("/").last!
    }

    let query = "writing_filepath CONTAINS '" + nameCleaned + "'"
    let results = RealmService.objectsForQuery(Writing.self, query: query)
    WritingService.current_writing_xref_object = (results.firstObject as! Writing) // @jtan: TODO: Just for now
  }
  
  private class func processWritings() {
    
    // Create the Realm Objects
    let items = NSFileManager.defaultManager().recursivePathsForResources(type: "txt")
    for item in items {
      let writing = createWriting(item)
      RealmService.createObject(writing)
    }
    
  }
  
  class func createWriting(path:String) -> Writing {
    let writing = Writing()
    writing.writing_filepath = path
    
    // Get the Title
    let title = NSString(string: path).lastPathComponent.stringByReplacingOccurrencesOfString(".txt", withString: "")
    writing.writing_title = title
    
    // Get ID
    let id = Util.uniqueString()
    writing.writing_id = id
    return writing
  }
  
  class func getCurrentBody() -> String {
    if current_writing_object != nil {
      let genericPath = current_writing_object?.writing_filepath
      let absolutePath = NSFileManager.localPathForItem(genericPath!)
      let body = try! NSString(contentsOfFile: absolutePath, encoding: NSUTF8StringEncoding)
      let bodyProcessed = body.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
      return bodyProcessed as String
    }
    return ""
  }
  
  class func getBodyForWriting(writing:Writing, start:Int?=nil, length:Int?=nil) -> String {
    let genericPath = writing.writing_filepath
    let absolutePath = NSFileManager.localPathForItem(genericPath)
    let body = try! NSString(contentsOfFile: absolutePath, encoding: NSUTF8StringEncoding)
    let bodyProcessed = body.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
    if start != nil && length != nil {
      let range : NSRange = NSMakeRange(start!, length!)
      let bodySub = (bodyProcessed as NSString).substringWithRange(range)
      return bodySub
    }
    return bodyProcessed
  }
  
  class func getCurrentXRefBody() -> String {
    if current_writing_xref_object != nil {
      let genericPath = current_writing_xref_object?.writing_filepath
      let absolutePath = NSFileManager.localPathForItem(genericPath!)
      let body = try! NSString(contentsOfFile: absolutePath, encoding: NSUTF8StringEncoding)
      let bodyProcessed = body.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
      return bodyProcessed as String
    }
    return ""
  }
}

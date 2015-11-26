//
//  Util.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

extension UILabel {
  func setTextForInt(int:Int) {
    self.text = String(format: "%d", int)
  }
}

extension NSFileManager {
  
  class func localPath() -> String {
    
    let path = NSBundle.mainBundle().resourcePath!
    return path
    
  }
  
  class func localPathForItem(item:String) -> String {
    return self.localPath() + "/" + item
  }
  
  func recursivePathsForResources(type type: String) -> [String] {
    
    let path = NSBundle.mainBundle().resourcePath!

    // Enumerators are recursive
    let enumerator = self.enumeratorAtPath(path)
    var filePaths = [String]()
    
    while let filePath = enumerator?.nextObject() as? String {
      
      if NSURL(fileURLWithPath: filePath).pathExtension == type {
        filePaths.append(filePath)
      }
    }
    
    return filePaths
  }
}
class Util: NSObject {
  
  //MARK: Traverse Bundle
  
  //MARK: Default Handlers
  class func notify(name:String) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil)
  }
  
  class func notifyData(name:String, data:NSDictionary) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil, userInfo: data as [NSObject : AnyObject])
  }

  class func storeDefault(key:String, value:AnyObject?) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  class func defaultValue(key:String)-> AnyObject? {
    return NSUserDefaults.standardUserDefaults().valueForKey(key)
  }
  
  class func removeDefaultWithKey(key:String) {
    NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  //MARK: Unique IDs
  class func uniqueString() -> String {
    return NSUUID().UUIDString
  }

  //MARK: Observer Handlers
  class func observe(target:AnyObject, action:Selector, named:String) {
    NSNotificationCenter.defaultCenter().addObserver(target, selector: action, name: named, object: nil)
  }
  class func removeObserve(target:AnyObject, named:String) {
    NSNotificationCenter.defaultCenter().removeObserver(target, name: named, object: nil)
  }

}
